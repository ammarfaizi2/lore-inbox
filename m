Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135678AbRDXPL3>; Tue, 24 Apr 2001 11:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135671AbRDXPLT>; Tue, 24 Apr 2001 11:11:19 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:24740 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S135678AbRDXPLI>; Tue, 24 Apr 2001 11:11:08 -0400
Date: Tue, 24 Apr 2001 10:11:06 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104241511.KAA22256@tomcat.admin.navo.hpc.mil>
To: linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Telensky <ttel5535@ss1000.ms.mff.cuni.cz>
> On Tue, 24 Apr 2001, Alexander Viro wrote:
> > On Tue, 24 Apr 2001, Tomas Telensky wrote:
> > 
> > > of linux distributions the standard daemons (httpd, sendmail) are run as
> > > root! Having multi-user system or not! Why? For only listening to a port
> > > <1024? Is there any elegant solution?
> > 
> > Sendmail is old. Consider it as a remnant of times when network was
> > more... friendly. Security considerations were mostly ignored - and
> > not only by sendmail. It used to be choke-full of holes. They were
> > essentially debugged out of it in late 90s. It seems to be more or
> > less OK these days, but it's full of old cruft. And splitting the
> > thing into reasonable parts and leaving them with minaml privileges
> > they need is large and painful work.

Actually, if you view sendmail as being an expert system it is very
cutting edge :-) It can identify a user from very skimpy data if it
is allowed to (fuzzy matching user names). It identifies local hosts
(with FQDN or partial name, or only host name).

> Thanks for the comment. And why not just let it listen to 25 and then
> being run as uid=nobody, gid=mail?

Because then everybodys mail would be owned by user "nobody".

There are some ways to do this, but they are unreliable.

   1. If the users mail is delivered to /var/mail/<username>; then the
      file /var/mail/<username> must always exist.

	This requires ALL MUAs to truncate the file.
	Some MUAs use file existance to determine if there is new mail.
	If it doesn't exist, then no new mail... ever.

   2. sendmail will not be able to create the /var/mail/<username> mail box.

   3. sendmail will not be able to process forwarding mail.
	User nobody should not be able to read files in users home
	directory... .forward files are private to the user...

   4. sendmail will not be able to process user mail filters (same problem
	as forwarding).

	Note: these filters are applied on receipt of mail (saves time and
	disk space since the filter can discard mail immediately or put it
	in appropriate folders immediately).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
