Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316380AbSETVPb>; Mon, 20 May 2002 17:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316382AbSETVPa>; Mon, 20 May 2002 17:15:30 -0400
Received: from [212.42.230.145] ([212.42.230.145]:17581 "EHLO
	pomo.hostsharing.net") by vger.kernel.org with ESMTP
	id <S316380AbSETVP3>; Mon, 20 May 2002 17:15:29 -0400
Date: Mon, 20 May 2002 23:15:26 +0200
From: Michael Hoennig <michael@hostsharing.net>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: pollard@tomcat.admin.navo.hpc.mil, linux-kernel@vger.kernel.org
Subject: Re: suid bit on directories
Message-Id: <20020520231526.12e24b48.michael@hostsharing.net>
In-Reply-To: <200205201928.OAA13328@tomcat.admin.navo.hpc.mil>
Organization: http://www.hostsharing.net
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

> > of course not, but many features have to be used carefully, like the
> > suid bit on files too!
> 
> That CAN be audited. Putting a suid on a directory CAN'T.

Of course it can. You can easily list all files with this flag set.

> > I don't want to make the bahaviour or a suid bit on directories the
> > default! I just would like it as a mount option, or even something
> > which you have to compile into the kernel.
> 
> Once mounted/compiled in you have lost control.

How do you come to that conclusion? Even if it were the case: I don't
force you to use this mount option.

> > Why do you ignore my example? In my example the use who runs the
> > webserver owns all the files, that is wrong. With the suid bit on
> > directories, this could be fixed. 
> 
> That is NOT wrong. The files belong to the server. Not a user. I've been
> running a server that way for years.

Files can only belong to users, not to server processes.

> And ANY user can put files into YOUR directory. Even files you don't
> want there. AND you can't tell who did it.

Nope. Only httpd and the user who should onw the files (the User of the
VirtualHost) can reach the directory in my case. Nobody else can even
reach it.

> Remember - with this facility any penetration of of a server suddenly
> becomes a penetration of every user with such a directory.

With the rights of wwwrun/httpd you can do more damange in this case than
with the rights of one user. In this case that are  special accounts for
running CGIs etc. 

> > > How are you going to control it?
> > 
> > Only the owner of the directories can set this flag. There is nothing
> > to control. 
> 
> Ah - so I can put files into your directory, and suddenly they are owned
> by you. 

You would not even reach this directory. That is assured because it is
child of a dir owned by me:httpd which is child of a directory owned by
httpd:mygroup - in neither case rights for others.

> Also remember what happens when a hard link is created in the
> directory... The file changes ownership. That will then change the owner
> of ANY file on the filesystem. I believe this can happen with sgid
> directories too

good point to pay attention to, but you are wrong


> > You don't! You just let it to the users to give access to there files
> > to whomever you want. My case is similar.
> 
> NOT the same situation. The OWNER of the file gives ACCESS to files. 

I coudl set up a cronjob which copies the files in the directories and
deletes the originals. It's the same, just delayed.

Anyway, when I find time in the next weeks, I will try this patch and post
it.  I will do it as a mount option.  Nobody is forced to use it ;-)

	Michael

-- 
Hostsharing eG / c/o Michael Hönnig / Boytinstr. 10 / D-22143 Hamburg
phone:+49/40/67581419 / mobile:+49/177/3787491 / fax:++49/40/67581426
http://www.hostsharing.net ---> Webhosting Spielregeln selbst gemacht
