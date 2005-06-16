Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVFPT6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVFPT6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 15:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVFPT57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 15:57:59 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:29104 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261801AbVFPT5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 15:57:45 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <42B1D880.9050305@namesys.com>
Date: Thu, 16 Jun 2005 12:52:32 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: "Theodore Ts'o" <tytso@mit.edu>, Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>,
       Andreas Dilger <adilger@clusterfs.com>, fs <fs@ercist.iscas.ac.cn>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <20050613201315.GC19319@moraine.clusterfs.com> <42AE1D4A.3030504@namesys.com> <42AE450C.5020908@dd.iij4u.or.jp> <20050615140105.GE4228@thunk.org> <42B091E3.3010908@namesys.com> <42B1681B.6000703@aitel.hist.no>
In-Reply-To: <42B1681B.6000703@aitel.hist.no>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge, the kernel needs to send a proper message to some proper demon
that does the right thing.  Neither proper message nor proper demon
currently exists.  If you think that what we have works, try unplugging
a USB drive while an unsophisticated user is using it.

The conversion to and then from these -EIO style codes with their
limited number of allowed values (what is it, 128 values? ) loses
information, such as what the user should do, and whether to tell the
user about it or just tell the app. 

The current system was not exactly designed by a usability expert.....

Some error messages need to be fs specific (e.g. hash collisions), and
some are not at all fs specific and should be standardized across all
filesystems (e.g. USB drive unplugged).

The essential point is that what we have now is incoherent and broken in
its usability.  Fixing it requires deep work, not surface work.  Deeper
work than I think Kennichi-san realized.  Lets not get mired in details
though of what API should be created until someone volunteers to do the
substantial labor required to unbreak the usability.  If someone were to
appear and offer to fix the usability, I would be happy to have
reiserfs/reiser4 cooperate with that.  Ted, what about ext2/3, would you
guys support such an effort?  Maybe if we are encouraging as a group,
someone will volunteer....

Hans

Helge Hafting wrote:

> Hans Reiser wrote:
>
>> What users need is for a window to pop up saying "the usb drive is
>> turned off" or "we are getting checksum errors from XXX, this may
>> indicate hardware problems that require your attention".
>>  
>>
> Nice.  And the way to do this right is to have the kernel merely
> log the error as usual.  The user can have some daemon listening
> to the log, this program may then pop up error messages with
> nifty detailed explanations, start up diagnostic software
> for various subsystems and so on.
> The kernel can't do GUI stuff - a GUI may or may not be present,
> and the kernel cannot know.  The server may not run X at all
> but I still run graphical SW on it using a workstation or X-terminal.
> Or the pc may have three video cards, each running a different xserver
> with different users for each.  Who to report to?
>
> An error-reporting daemon have an easier job, it can look up the
> correct (possibly remote) display in its config file for all those
> cases when there isn't just _one_ display.
>
> Helge Hafting
>
>
>
>
>
>

