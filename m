Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273145AbRIJBbl>; Sun, 9 Sep 2001 21:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273137AbRIJBbd>; Sun, 9 Sep 2001 21:31:33 -0400
Received: from mail207.mail.bellsouth.net ([205.152.58.147]:45507 "EHLO
	imf07bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S273142AbRIJBbZ>; Sun, 9 Sep 2001 21:31:25 -0400
Message-ID: <3B9C183D.52FCAD7C@bellsouth.net>
Date: Sun, 09 Sep 2001 21:32:45 -0400
From: Alicia Whisnant <jdwyatt@bellsouth.net>
Reply-To: jdwyatt@bellsouth.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rvandam@liwave.com, linux-kernel@vger.kernel.org
CC: "'Frank Schneider'" <SPATZ1@t-online.de>
Subject: Re: FW: OT: Integrating Directory Services for Linux
In-Reply-To: <001501c1398f$5bb85c40$1f0201c0@w2k001>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ron Van Dam wrote:
>  Using ADS or NDS is not a good solution, because in my opinion, it would be
> dependent on a another OS. I would rather have the DS maintained on a
> OpenSource OS. 

That's just not true anymore, at least not for NDS.  Novell's latest
version (called "eDirectory" these days) runs very gracefully on Linux
(and solaris, too, FWIW).  It's possible to run an entire NDS
infrastructure without running any netware these days.  This has been
out for
quite awhile.
Go to this page and scroll down to "eDirectory", and you can download
and play with it yourself:
http://download.novell.com/sdMain.jsp
Note that the package also includes PAM login modules for linux.  Also
note full LDAP compatibility.

As a side note, novell has an intriguing metadirectory technology called
DirXML, which can glue any directory to any other directory with XML
templates.  You can use it to synchronize an Oracle table with an NDS
userlist, for example.

> NIS+ is basically obsolete.

Hrm, please qualify that.  Why do you think it's obsolete?  It's
considerably more advanced (and certainly more secure) than most of the
other options out there, including LDAP-over-SSL.  Just a bitch to
admin.

> OpenLDAP could be turned into a
> workable solution, but there is no "consistent" bridge between OpenLDAP and
> Linux. For instance if you want to manager user accounts with it you need
> PAM, and unfortunately PAM isn't compatible with a lot of userland
> applications and services.

PAM is the standardized and agreed-upon method for divorcing
authentication from the system.  It's been like that for quite some time
now.  What if this discussion was about some Linux GUI apps not being
compatible with X?  The boat's been sailing for quite some time, either
hop on or build your own, I say, or swim (sink?).

<snip>
> I don't think DS will work unless there some standard for DS established by
> the core linux development groups. Another words, what I would like have is
> the framework for a standard for implemeting DS for Linux.

What's wrong with the name service switch stuff?  and more importantly,
PAM?
The "PAM isn't supported by enough apps" argument is kind of weak. 
Reason being that the developer chose not to support it.  I for one
don't think the kernel should be modified just because Joe Blow
hardcoded open (/etc/passwd), or whatever.

<snip>
> I started this discussion to see if anyone out there considers DS important
> for Linux growth.  I am not sugguesting that this should be in the kernel.
> Just some sort of directory system that can manage configurations of a large
> number of linux boxes.

I personally believe that nothing will be so pivotal in a desktop war as
a good, unified directory.  Is the desktop a growth area for Linux?  You
betcha.  There are other areas (i.e. embedded) that Linux could benefit
from directories, too (think of a cellphone that anyone could use by
"logging into" it).

> However, I don't see how you can manage permissions to kernel function calls
> with out some kernel support. 

Pluggable Authentication Modules

> Depending on what level of functionally is
> included, there may be a need access database information during boot-up,
> before userland processes can be started. 

Who, besides root, would ever need to perform activities before userland
processes can start?

> If you managing kernel functions
> calls for userland access, how can you tell if the process has permissions
> unless some functionally is built-in the kernel? Think of a directory
> service operating more like a file system than a database.

Handled all by PAM and name service switch.

<snip>

> How would you manage 1000 or 10,000 desktop boxes each with their own /etc
> directory?  Imagine your supporting several hundred or even several thousand
> unix boxes, and you need to apply a standard change to all of them. Lets
> also assume your not getting paid by the hour, or you need to get the change
> done in just a hour or two. Would you trust a running a script on a
> /etc/*.conf file to apply a change on your boxes? I suppose if you really
> like to torture yourself, you could modify each of those files by hand,
> ouch!

Agreed, by hand it would be painful.  But why are scripts so scary? 
Just don't screw up :) .
I have played on a team which maintained 1000+ solaris and sunos
workstations, each with their own /etc, for a userlist > 7000 users. 
Everything (passwd, shadow, group, printcap, etc) lived in NIS. 
Individual changes to system files were made with rdist or cronjobs.  I
believe Linux+LDAP (or even NDS, because of the awesome performance)
would be much better suited to this task.

As long as you do enough testing, it's probably the ultimate way to
maintain lots of machines.  Again, note that this was done with an
obsolete (in my opinion, this time :) directory services (NIS).

> Thanks for the response.
> Ron

Thanks,
Josh

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

