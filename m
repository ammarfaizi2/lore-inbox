Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315883AbSFTXel>; Thu, 20 Jun 2002 19:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315893AbSFTXek>; Thu, 20 Jun 2002 19:34:40 -0400
Received: from ns.suse.de ([213.95.15.193]:29962 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315883AbSFTXej>;
	Thu, 20 Jun 2002 19:34:39 -0400
Date: Fri, 21 Jun 2002 01:34:36 +0200
From: Dave Jones <davej@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: andersg@0x63.nu, linux-kernel@vger.kernel.org,
       whitney@adsl-209-76-109-63.dsl.snfc21.pacbell.net
Subject: Re: /proc/partitions broken in 2.5.23
Message-ID: <20020621013436.V29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, Andries.Brouwer@cwi.nl,
	andersg@0x63.nu, linux-kernel@vger.kernel.org,
	whitney@adsl-209-76-109-63.dsl.snfc21.pacbell.net
References: <UTC200206202321.g5KNLeT22807.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200206202321.g5KNLeT22807.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Jun 21, 2002 at 01:21:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 01:21:40AM +0200, Andries.Brouwer@cwi.nl wrote:

 >     > I got a bug report about an issue with LVM in 2.5.22-dj1, which turns
 >     > out to be caused by broken /proc/partitions in mainline.
 >     > 
 >     > (davej@mesh:davej)$ cat /proc/partitions 
 >     > major minor  #blocks  name
 >     > 
 >     >    8     0          0 sda
 >     >   22     0 1515870810 hdc
 >     > 
 >     > Note the huge numbers in hex are 0x5a5a5a5a, so something
 >     > seems to be getting poisoned somewhere.
 > 
 > Is this LVM?

No.
 
 > I don't see how LVM could produce such values.
 > (And in fact LVM does not even compile, so only a patched LVM
 > could produce anything at all.)

The original person who reported a problem to me used LVM, and 
in the course of discussion, the proc/partitions bug came to light.
The values pasted above are from a box with no LVM compiled.

 > Normally the nr_real field indicates how many devices are
 > present. But LVM sets that to 256 even when nothing is present.
 > So, indeed, when all size fields are set to 0 this would probably
 > yield a list of 256 absent LVM devices.
 > Maybe LVM has to be fixed, or this patch fragment reverted, or both.

As I mentioned in another mail, it seems that removable devices with
no media have no valid #blocks, and is thus getting poisoned.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
