Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbRELLu7>; Sat, 12 May 2001 07:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261230AbRELLut>; Sat, 12 May 2001 07:50:49 -0400
Received: from wawura.off.connect.com.au ([202.21.9.2]:29649 "HELO
	wawura.off.connect.com.au") by vger.kernel.org with SMTP
	id <S261228AbRELLuh>; Sat, 12 May 2001 07:50:37 -0400
To: tytso@valinux.com, linux-kernel@vger.kernel.org
Subject: Ext2, fsync() and MTA's?
Date: Sat, 12 May 2001 21:50:34 +1000
From: Andrew McNamara <andrewm@connect.com.au>
Message-Id: <20010512115034.A6245285B9@wawura.off.connect.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the following still true in 2.4 (fsync() doesn't ensure directory
and inode data is up to date)? I had a feeling this had been fixed.

Under Linux, the Postfix MTA sets "chattr +S" on it's spool directories
- obviously this hurts it's performance badly (compared to the BSD's).
It would be really nice to be able to say it's no longer necessary. It
wants to know that a file (file data, inode and directory entry) are
commited to stable storage when an fsync returns.

------- Forwarded Message

Date:    Fri, 11 May 2001 19:17:03 -0400
From:    wietse@porcupine.org (Wietse Venema)
To:      Postfix users <postfix-users@postfix.org>
Subject: Re: maildir or not

David W. Chapman Jr.:
> I think that's the point.  Linux's fsync doesn't fsynch like most other
> unices, it still writes async.  There fore its not totally stable because
> you think you are writting sync when in fact you aren't.  I might be wrong,
> but this is what I have been hearing.

Linux fsync flushes the file data blocks.

The debate is about Linux's directory updates.

Postfix can open/write/fsync/close a file successfully, and Linux
can still lose the file because the directory entry was not updated.

This is why Postfix turns on synchronous writes on dircetories.
Unfortunately, that also makes file writes synchronous.  I will
not sacrifice reliability for the sake of performance.

	Wietse

- -
To unsubscribe, send mail to majordomo@postfix.org with content
(not subject): unsubscribe postfix-users


------- End of Forwarded Message

