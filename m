Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278328AbRJMQsH>; Sat, 13 Oct 2001 12:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278335AbRJMQr6>; Sat, 13 Oct 2001 12:47:58 -0400
Received: from mx0.gmx.net ([213.165.64.100]:22882 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S278328AbRJMQrs>;
	Sat, 13 Oct 2001 12:47:48 -0400
Date: Sat, 13 Oct 2001 18:48:19 +0200 (MEST)
From: Michael Kerrisk <m.kerrisk@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0005657596@gmx.net
X-Authenticated-IP: [213.6.191.169]
Message-ID: <6126.1002991699@www50.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

[Hmmm, tried postin this from another address but it doesn't seem to have
maed it through - this is another shot, apologies if it turns out to be a
duplicate]

I've put this question out on C.O.L.D.S, but have not really received any
conclusive answer, and archive searches don't seem to reveal anything, so
I'll bring it here...

I'm slightly puzzled about the use of the file system UID and GID
features.  The setfsuid(2) man page says:

>> An explict call to setfsuid is usually only used  by  pro­
>> grams  such  as  the  Linux NFS server that need to change
>> what user ID is used for file access without a correspond­
>> ing change in the real and effective user IDs. A change in
>> the normal user IDs for a program such as the  NFS  server
>> is  a security hole that can expose it to unwanted signals
>> from other user IDs.

Now I can see that it can be convenient for the NFS server to change the
FSUID in order to masquerade as another user for the purposes of file
access permissions, while at the same time maintaining privileges via the
effective/saved set-user IDs.  

However, the statement about signals sounds strange to me: on Linux (as
with other Unices), one process can send another process a signal if the
[REAL or EFFECTIVE UID of the sender] matches the [REAL or SAVED SET-
USER-ID of the receiver].

Thus a process could use (say) seteuid(2) to change the process' 
effective UID (while leaving the real and saved set-user-id unchanged) ,
and still not be a target for signals sent by another process with the
same real of effective UID.  In other words, the FSUID doesn't appear to
be necessary, at least from the point of view of protection from signals. 

Is the explanation on the manual page incomplete?  Or have I missed
something?  (I've had a read of the NFS sources and haven't been 
enlightened.)

Thanks,

Michael

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

