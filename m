Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTEFPws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTEFPws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:52:48 -0400
Received: from www1.mail.lycos.com ([209.202.220.140]:39489 "HELO lycos.com")
	by vger.kernel.org with SMTP id S263894AbTEFPwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:52:45 -0400
To: linux-kernel@vger.kernel.org, "Peder Stray" <peder@ifi.uio.no>
Date: Tue, 06 May 2003 12:04:54 -0400
From: "Sumit Narayan" <sumit_uconn@lycos.com>
Message-ID: <JLMGNFCLNCBCCDAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: sumit_uconn@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: Files truncate on vfat filesystem
X-Sender-Ip: 137.99.1.12
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peder,

I think the problem that you are facing is because you umount the disk immediately after transferring the file. Though ls indicates that the file has been transferred, and the size match, the transfer would still be in progress behind the scene, and once you umount, and remove the USB disk, the data is lost, since the transfer was not complete. You are facing this problem randomly, depending on how long you wait after the transfer to remove the disk. This happens when you are transferring large files, and not while using small files. This will happen even when you are transferring large files from your CDs.
I hope this helps. Just wait for few seconds after the transfer is done, and you wont lose your data anymore.

Regards,
Sumit 
--

On 06 May 2003 17:29:12 +020  
 Peder Stray wrote:
>
>I have a 250GB usb-storage disk i use to transport large files between
>work and home, I uses vfat (since I haven't found any other good
>filesystems that don't require me to either be root or have all files
>worldreadable). Anyways...
>
>Some files get its size truncated to 0 after a while (usually a few
>minuts, or when i umount the disk). They seem to be the correct size
>when I do ls -l immediately after i have transfered the files (with cp
>or rsync, doesn't really matter). Moving files on the disk with mv also
>seems to trigger the problem sometimes.
>
>I see that blocks get allocated, but the filesizes are 0. Currently
>there is a difference of 17GB in the output of df and du.
>
>I have also noticed that the size of some directories get truncated too,
>thus all files copied or moved into those directories dissappear. ls -l
>in those directories doesn't even show . and ..
>
>it seem very inconsistent which files are affected, both in size, length
>of filename, unusual characters or depth in the filestructure. No
>messages from the kernel logs.
>
>A check of the filesystem from XP reports no errors in the
>filestructure, and it work 100% there.
>
>kernel versions used are are amongst 2.4.18 and 2.4.20, selfcompiled or
>stock from RH.
>
>More details can of course be supplied if anyone have any ideas what to
>check and how.
>
>any comments or help would be much appreciated as the loss of data i
>experience is more than a little annyoing.
>
>-- 
>  Peder Stray
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
