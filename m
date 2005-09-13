Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVIMQWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVIMQWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVIMQWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:22:41 -0400
Received: from falcon30.maxeymade.com ([24.173.215.190]:58753 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S964845AbVIMQWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:22:40 -0400
Message-Id: <200509131622.j8DGMLwF029752@falcon30.maxeymade.com>
X-Mailer: exmh version 2.7.2.1 01/17/2005 with nmh-1.1
In-reply-to: <1126620753.3209.3.camel@windu.rchland.ibm.com> 
To: Josh Boyer <jdub@us.ibm.com>
cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Missing #include <config.h> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1126628412_293790"
Date: Tue, 13 Sep 2005 11:22:21 -0500
From: Doug Maxey <dwm@maxeymade.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_1126628412_293790
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


On Tue, 13 Sep 2005 09:12:33 CDT, Josh Boyer wrote:
>On Tue, 2005-09-13 at 14:56 +0100, J=F6rn Engel wrote:
>> After spending some hours last night and this morning hunting a bug,
>> I've found that a different include order made a difference.  Some
>> files don't work correctly, unless config.h is included before.
>>=20
>> Here is a very stupid bug checker for the problem class:
>> =24 rgrep CONFIG include/ =7C cut -d: -f1 =7C sort -u > g1
>> =24 rgrep CONFIG include/ =7C cut -d: -f1 =7C sort -u =7C xargs grep =
=22config.h=22 =7C cut -d: -f1 =7C sort -u > g2
>> =24 diff -u g1 g2 =7C grep =5E- > g3
>
>Your checker doesn't quite test for nested includes.  E.g. if foo.h
>includes bar.h, and bar.h includes config.h, then foo.h doesn't need to
>include config.h explicitly.
>
>For a more concrete example, take include/asm-i386/kprobes.h from your
>list.  That includes linux/types.h, which includes linux/config.h.
>
>Making a tool that takes that into account could be interesting.
>
>josh
>
>-
>To unsubscribe from this list: send the line =22unsubscribe linux-kernel=
=22 in
>the body of a message to majordomo=40vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

Going Way Back - there was a perl script floating around last century=20
named 'inctree' that did what he was looking for...

++doug


--==_Exmh_1126628412_293790
Content-Type: text/plain ; name="inctree"; charset=iso-8859-1
Content-Description: inctree
Content-Transfer-Encoding: quoted-printable

=23=21/usr/local/bin/perl
=23 =24Id: inctree,v 1.1.1.1 2001/11/16 17:16:36 dwm Exp =24
=23 =24Header: /cvs/local/share/inctree,v 1.1.1.1 2001/11/16 17:16:36 dwm=
 Exp =24
=23 =24Log: inctree,v =24
=23 Revision 1.1.1.1  2001/11/16 17:16:36  dwm
=23 after rome burned.
=23
=23 Revision 1.1  2001/11/16 17:16:36  dwm
=23 .
=23
=23 Revision 1.10  1998-06-11 09:35:42-05  dwm
=23 *** empty log message ***
=23
=23 Revision 1.9  1998-06-11 09:32:20-05  dwm
=23 *** empty log message ***
=23
=23 Revision 1.8  1996-06-20 11:09:00-05  dwm
=23 *** empty log message ***
=23
=23 Revision 1.7  1996-06-20 11:06:47-05  dwm
=23 sucks on AIX build tree.
=23
=23 Revision 1.6  1996-06-20 08:39:46-05  dwm
=23 *** empty log message ***
=23
=23 Revision 1.5  1996-06-20 08:34:11-05  dwm
=23 fix for using other compiler.
=23
=23 Revision 1.4  1995-06-07 20:15:35-0500  dwm
=23 now we exclude the -c, -f*, and -M* compiler flags.
=23
=23 Revision 1.3  1994-06-08 22:46:37-0500  dwm
=23 added support for C++
=23
=23 Revision 1.2  1993/07/16  04:06:56  dwm
=23 Zthe -? neeeded a =5C.
=23
=23 Revision 1.1  1993/07/16  03:51:35  dwm
=23 Initial revision
=23

require 5.004;

=23 'inctree' created 93/07/09 11:40 to validate/print the =23includes
=23 for files.
=23 from the camel book, p274
=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=
=23=23=23=23=23=23=23=23=23
=23=23=23=23=23=23=23=23=23=23=23=23 GLOBALS =23=23=23=23=23=23=23=23=23=
=23=23=23
=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=
=23=23=23=23=23=23=23=23=23
( =24prog =3D =240 ) =3D=7E  s=23.*/=23=23o ; =240 =3D join(' ', =24prog,=
 =40ARGV) ;
=24CPP =3D =24ENV=7B'CPP'=7D =7C=7C 'gcc -E' ;
=24shiftwidth =3D 4 ;

=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=
=23=23=23=23=23=23=23=23=23
=23=23=23=23=23=23=23=23=23=23 SUBROUTINES =23=23=23=23=23=23=23=23=23=23=

=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=
=23=23=23=23=23=23=23=23=23
sub usage
=7B
    print STDERR =40_ if =40_ ;
    print STDERR <<=22EOU=22 ;
usage: =24prog =5B-d=5D =5B-D...=5D =5B-I...=5D =5B-l=5D =5B-m/pattern/=
=5D file...

 =24prog runs the C preprocessor (default =24CPP) on the specified files,=

 passing along any -D or -I switches, then processes the output of
 cpp into a tree of who included what.  Files included more than
 once are marked DUPLICATE.

 flags:
 -C...  preprocessor definition (default =24CPP_name).
 -D...	defines for the preprocessor.
 -I...  dirs to search for the =23include files.
 -d	prints debugging info.
 -h=7C-?	print this message.
 -l	prints the line numbers of the include statements.
 -m/../	outputs any lines including the pattern specified.
 -s=5Cd	sets shiftwidth (default =24shiftwidth).
EOU
    exit 1 ;
=7D

=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=
=23=23=23=23=23=23=23=23=23
=23=23=23=23=23=23=23=23=23=23=23=23   MAIN  =23=23=23=23=23=23=23=23=23=
=23=23=23
=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=23=
=23=23=23=23=23=23=23=23=23
=23 require 'getopts.pl' ;
=23 &Getopts('dD:I:lm:') =7C=7C &usage ;
while ( =24ARGV=5B0=5D =3D=7E /=5E-/ )
=7B
    =24_ =3D shift ;
    if (/=5E-C(.*)/)
    =7B
	=24opt_cpp =3D ( =241 ? =241 : shift ) ;
    =7D
    elsif (/=5E-(=5BDU=5D)(.*)/)
    =7B
	=24defines .=3D =22 -=241=22 . (=242 ? =242 : shift );
    =7D
    elsif (/=5E-I(.*)/)
    =7B
	=24includes .=3D =22 -I=22 . (=241 ? =241 : shift );
    =7D
    elsif (/=5E-m(.*)/)
    =7B
	push(=40pats, =241 ? =241 : shift );
    =7D
    elsif ( /=5E-d/ )
    =7B
	=24debug++ ;
    =7D
    elsif ( /=5E-l/ )
    =7B
	=24lines++ ;
    =7D
    elsif (/=5E-s(.*)/)
    =7B
	=24shiftwidth =3D ( =241 ? =241 : shift ) ;
    =7D
    elsif (/=5E-h=7C=5E-=5C?/)
    =7B
	&usage ;
    =7D
     =23 other compiler flags
    elsif (/=5E-g(.*)=7C=5E-O(.*)=7C=5E-traditional=7C=5E-c=7C=5E-f(.*)=
=7C=5E-M(.*)/)
    =7B
	next ;
    =7D
    elsif (/=5E-v=24/ )
    =7B
	=24verbose =3D =24_ ;
    =7D
    else
    =7B
	push (=40ccopts, =24_);
	=23&usage(=22Unrecognized switch =24_=5Cn=22) ;
    =7D

=7D

print STDERR =22=24defines=5Cn=22 if =24debug ;
print STDERR =22=24includes=5Cn=22 if =24debug ;

 =23 build a subroutine to scan for patterns
if ( =40pats )
=7B
    =24sub =3D =22sub pats ()=5Cn=7B=5Cn=22 ;
    foreach =24pat ( =40pats )
    =7B
	=24sub .=3D =22    print '>>>>>>> ',=5C=24_ if m=24pat;=5Cn=22 ;
    =7D
    =24sub .=3D =22=7D=5Cn=22 ;
    print STDERR =24sub if =24debug ;
    eval =24sub ;
    die =24=40 if =24=40 ;
    ++=24pats ;
=7D

 =23 process each file.
foreach =24file (=40ARGV)
=7B
    if (length =24opt_cpp)
    =7B
	=24CPP_name =3D =24opt_cpp;
    =7D
    elsif (=24file =3D=7E /.C=24=7C.cc=24/) =7B
	=24CPP_name =3D =22g++ -E=22 ;
    =7D
    else =7B
	=24CPP_name =3D =24CPP ;
    =7D

    =24ccopts =3D join (=22 =22, =40ccopts);
    =24pipecmd =3D =22=24CPP_name =24verbose =24ccopts =24defines =24incl=
udes =24file=7C=22 ;
    open(CPP,=24pipecmd)
	=7C=7C die =22Can't run =24pipecmd: =24=21=5Cn=22 ;
    =24line =3D 2 ;

    while (<CPP>)
    =7B
	++=24line ;
	pats () if =24pats ;	=23 avoid expensive call if we can.
	next unless /=5E=23/ ;
	next unless /=5E=23 =5Cd/ ;
	(undef, =24newline, =24filename) =3D split ;
	=24filename =3D=7E s/=5C=22//g ;

	 =23 now figure out if it's push, pop, or neither.
        if (=24stack=5B=24=23stack=5D eq =24filename)
        =7B
	    =24line =3D =24newline - 1 ;
	    next ;
        =7D

        if (=24stack=5B=24=23stack - 1=5D eq =24filename)	=23 Leaving fil=
e.
        =7B
	    =24indent -=3D =24shiftwidth ;
	    =24line =3D pop(=40lines) - 1 ;
	    pop(=40stack) ;
        =7D
        else					=23 New file.
        =7B
	    printf =22%6d =22, =24line -2 if =24lines ;
	    push(=40lines, =24line) ;
	    =24line =3D =24newline ;
	    print =22=5Ct=22 x (=24indent / 8), ' ' x (=24indent % 8),
		=24filename ;
	    print =22  DUPLICATE=22 if =24seen=7B=24filename=7D++ ;
	    print =22=5Cn=22 ;
	    =24indent +=3D =24shiftwidth ;
	    push(=40stack, =24filename) ;
        =7D
    =7D
    close CPP ;
    =24indent =3D 0 ;
    %seen =3D () ;
    print =22=5Cn=5Cn=22 ;
    =24line =3D 0 ;
=7D
exit 0

--==_Exmh_1126628412_293790--


