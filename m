Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTB0Q3z>; Thu, 27 Feb 2003 11:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbTB0Q3y>; Thu, 27 Feb 2003 11:29:54 -0500
Received: from dsl-212-144-205-077.arcor-ip.net ([212.144.205.77]:20100 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S265446AbTB0Q3w> convert rfc822-to-8bit; Thu, 27 Feb 2003 11:29:52 -0500
From: Dominik Kubla <dominik@kubla.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: About /etc/mtab and /proc/mounts
Date: Thu, 27 Feb 2003 17:40:03 +0100
User-Agent: KMail/1.5
Cc: Kasper Dupont <kasperd@daimi.au.dk>, Miles Bader <miles@gnu.org>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
References: <200302271600.h1RG0Cdh011948@eeyore.valparaiso.cl>
In-Reply-To: <200302271600.h1RG0Cdh011948@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200302271740.06139.dominik@kubla.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 February 2003 17:00, Horst von Brand wrote:
> Dominik Kubla <dominik@kubla.de> said:
> > Quoting the Solaris 8 man page:
>
> I fail to see any significant difference to /proc/mounts (possibly
> expanded). Sure, /proc is the wrong place for this kind of stuff, but...

Then i suggest that you re-read the mnttab(4) man page and compare
it to the Linux implementation.  :-)

Keep in mind that i only qouted some parts of the man page. Some thing
are just details (but as we all know details do matter):

[Linux]
# ls -l /proc mounts
lrwxrwxrwx    1 root     root           11 Feb 27 17:10 /proc/mounts -> 
self/mounts
# ls -l /proc/self/mounts
-r--r--r--    1 root     root            0 Feb 27 17:11 /proc/self/mounts
# wc -c /proc/self/mounts
   1058 /proc/self/mounts

[Solaris]
# ls -l /etc/mnttab
 r--r--r--   1 root         1178 Feb 25 16:26 /etc/mnttab
# wc -c /etc/mnttab
    1178 /etc/mnttab

The snapshot feature as quoted in the man page is not present under
Linux.  The poll(2) feature is not implemented. The solaris mntfs also
implements special ioctrls. Quoting the man page again:

[...]
IOCTLS
     The following ioctl(2) calls are supported:

     MNTIOC_NMOUNTS
           Returns the count of mounted resources in the  current
           snapshot in the uint32_t pointed to by arg.

     MNTIOC_GETDEVLIST
           Returns an array of uint32_t's that is twice  as  long
           as the length returned by MNTIOC_NMOUNTS. Each pair of
           numbers  is the major and minor device number for  the
           file  system at the corresponding  line in the current
           /etc/mnttab snapshot. arg points to the memory  buffer
           to receive the device number information.

    MNTIOC_SETTAG
           Sets a tag word into the options list  for  a  mounted
           file  system.  A tag is a notation that will appear in
           the options string of a mounted file system but it  is
           not recognized or interpreted by the file system code.
           arg points to a filled  in  mnttagdesc  structure,  as
           shown in the following example:

           uint_t  mtd_major; /* major number for mounted fs */
           uint_t  mtd_minor; /* minor number for mounted fs */
           char    *mtd_mntpt; /* mount point of file system */
           char    *mtd_tag;  /* tag to set/clear */

           If the tag already exists then it is marked as set but
           not re-added. Tags can be at most MAX_MNTOPT_TAG long.

     MNTIOC_CLRTAG
           Marks a tag in the options list  for  a  mounted  file
           system as not set. arg points to the same structure as
           MNTIOC_SETTAG, which identifies the  file  system  and
           tag to be cleared.
[...]

There is also an extended set of library functions to go along with that,
eg. getmntany(3), getextmntent(3), resetmnttab(3) and hasmntopt(3).

It is very helpful that one can get the time a mount happened! You can
not get this kind of information on Linux, neither from /etc/mtab nor from
/proc/self/mounts.

getextmnttab(3) also gives easy access to the device major and minor
number of the mount point.

So there are quite some differences between the Linux proc file and
the Solaris mntfs filesystem.  If these differences justify us doing it the
same way is debateable.

The strongest argument i see is: It's already been done this way by one
major Unix version, so why should Linux reinvent the wheel. Again.

Regards,
  Dominik
-- 
"What this  country needs is  a short, victorious war  to stem the  tide of
revolution." (V.K. von Plehve, Russian Minister  of Interior on the  eve of
the Russo-Japanese war.)

