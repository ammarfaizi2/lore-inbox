Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314089AbSDVIVs>; Mon, 22 Apr 2002 04:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314090AbSDVIVr>; Mon, 22 Apr 2002 04:21:47 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:14263 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S314089AbSDVIVq>;
	Mon, 22 Apr 2002 04:21:46 -0400
Message-Id: <3.0.6.32.20020422102513.00912970@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Mon, 22 Apr 2002 10:25:13 +0200
To: nahshon@actcom.co.il, Andrew Morton <akpm@zip.com.au>
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: Re: [PATCH] open files in kjounald (2)
Cc: sct@redhat.com, adilger@turbolinux.com, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
In-Reply-To: <200204221056.04322.nahshon@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Confused.  The daemonize() call makes kjournald use init's
>> files:
>
>That's because in daemonize() we have:
>
>        exit_files(current);
>        current->files = init_task.files;		<====
>        atomic_inc(&current->files->count);	<====
>
>But why should a kernel-daemon need init's files?
>
>
>
>Some places call both daemonize() _and_ exit_files() which is
>redundant (checking on 2.4.19-pre7-a2):
>
>	block/loop.c :: loop_thread()
>	usb/storage/usb.c :: usb_stor_control_thread()
Well, I have 2.4.19rc2 and 2.4.19pre1.

I took the line from loop.c :-) that's where it worked.

I found another problem: in scsi_error_handler. see
drivers/scsi/scsi_error.c; I inserted exit_files(current) in line 1862.


Regards,

Phil


