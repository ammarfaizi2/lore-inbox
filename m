Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTKLW6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 17:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTKLW6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 17:58:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:64952 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261680AbTKLW6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 17:58:40 -0500
Date: Wed, 12 Nov 2003 14:54:12 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: mfedyk@matchmail.com, info@avistor.com, linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
Message-Id: <20031112145412.226c789f.rddunlap@osdl.org>
In-Reply-To: <16304.23206.924374.529136@wombat.chubb.wattle.id.au>
References: <16304.9647.994684.804486@wombat.chubb.wattle.id.au>
	<HBEHKOEIIJKNLNAMLGAOIECPDKAA.info@avistor.com>
	<20031111022140.GE2014@mis-mike-wstn.matchmail.com>
	<16304.23206.924374.529136@wombat.chubb.wattle.id.au>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003 14:42:30 +1100 Peter Chubb <peter@chubb.wattle.id.au> wrote:

| >>>>> "Mike" == Mike Fedyk <mfedyk@matchmail.com> writes:
| 
| > On Mon, Nov 10, 2003 at 06:12:06PM -0800, Joseph Shamash wrote:
| >> 
| >> What is the maximum partition size for a patched 2.4.x kernel, and
| >> where are those patches?
| 
| Mike> I believe it is now 16TB per block device in 2.6, and patched
| Mike> 2.4.
| 
| That's right for 32-bit systems with 4k pages.  For 64 bit systems the
| limit is over 8 Exabytes.
| 
| You should note that software raid has smaller limits, as does the
| LVM.  Also the 2.4 patches have seen *much* less testing than the 2.6
| mainline (except possibly on the SGI Altix).
| 
| What exactly are you trying to do?


I made the table below for LinuxWorld Expo/Conference in Aug. 2002,
for Linux 2.4.x on 32-bit architectures, so it is a bit out of date,
but it might be helpful or useful.

--
~Randy
MOTD:  Always include version info.





Linux 2.4 filesystem limits on 32-bit architectures,
with 4 KB block sizes:


                     ext2/3fs    reiserfs     JFS       XFS#
max filesize:          4 TB&      16 TB$     16 TB$%  16 TB$
max filesystem size:  16 TB&      16 TB&     16 TB$   16 TB$
		                              4 PB&    8 EB&
kernel bldev limit:    2 TB        2 TB       2 TB     2 TB 


Notes:
#: all kernel limits
$: kernel limit
%: 4 KB pages
@: block device limit: 2 TB (or 1 TB if signed)
&: fs limit



Another look at ext2/3fs limits:

  Assumes using 4 KB block sizes on a 32-bit architecture
  (64-bit architecture isn't very limiting).

Largest limiting factor
           |
	   v
Smallest limiting factor


1.  64-bit API limit:  8 EiB

2.  kernel page cache index limit (32 bits) == filesystem block number:
    2^32 * 4 KB = 16 TiB

3.  ext2fs triple-indirect block limit:  4 TiB

4.  kernel block device limit (device sector number):  2 TiB
    (or 1 TiB if signed)

###
