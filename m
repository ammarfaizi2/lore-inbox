Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129770AbQKYSRA>; Sat, 25 Nov 2000 13:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131418AbQKYSQw>; Sat, 25 Nov 2000 13:16:52 -0500
Received: from janus.hosting4u.net ([209.15.2.37]:30736 "HELO
        janus.hosting4u.net") by vger.kernel.org with SMTP
        id <S129770AbQKYSQi>; Sat, 25 Nov 2000 13:16:38 -0500
Message-ID: <3A1FFA2C.A8980FD8@a2zis.com>
Date: Sat, 25 Nov 2000 18:43:08 +0100
From: Remi Turk <remi@a2zis.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CLONE_NAMESPACE, links for dirs and mount(2) for normal users questions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Long long ago, (March 2000) Alexander Viro replied to Pavel Machek:
>> Am I right that from now on each process can have completely different
>> view of filesystem like in plan9?
>
>Almost there ;-) And yes, the only thing we lack for proper namespaces is
>the union-directories (clone() bit is trivial).
Are there any patches already?
If not, where should I start to implement them?

Probably related to the first question, what about allowing mount(2)
(as a CONFIG-option) for normal user processes when they
have a) rw access to the device and b) are the owner/have rw-access
to the mountpoint. (There would be at least one security problem:
A normal user could mount a loopback ext2 filesystem with
panic-on-error (man tune2fs) and then corrupt it)

In April, Al Viro wrote:
> 1.  We should never have more than one dentry for a writable directory.
> 
> Print it and hang it on the wall. It's a fundamental requirement. There is
> no way to work around it in our VFS. I tried to invent a scheme that would
> allow that for more than a year. And I've done most of namespace-related code
> in our VFS since the moment when Bill Hawes stopped working on it, so I suspect
> that right now I have the best working knowledge of that stuff. There is no
> fscking way to survive multiple dentries for writable directory without major
> lossage. Period.
Do I understand correctly that this means hardlinks to directories
(except . and ..) are fundamentally impossible in Linux?
(I'm thinking about trying to write a garbage collected
filesystem with hardlinks to directories.)

-- 
Linux 2.4.0-test11 #1 Mon Nov 20 17:19:26 CET 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
