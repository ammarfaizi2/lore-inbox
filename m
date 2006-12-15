Return-Path: <linux-kernel-owner+w=401wt.eu-S1752043AbWLOAL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbWLOAL1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWLOAL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:11:27 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:35721 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbWLOAL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:11:26 -0500
X-Originating-Ip: 74.109.98.100
Date: Thu, 14 Dec 2006 19:07:27 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
In-Reply-To: <4581D355.1000701@oracle.com>
Message-ID: <Pine.LNX.4.64.0612141906270.27378@localhost.localdomain>
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
 <20061214223850.GC25114@vasa.acc.umu.se> <4581D355.1000701@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006, Randy Dunlap wrote:

> David Weinehall wrote:
> > On Thu, Dec 07, 2006 at 12:48:38AM -0800, Randy Dunlap wrote:
> >
> > [snip]
> >
> > > +but no space after unary operators:
> > > +		sizeof  ++  --  &  *  +  -  ~  !  defined
> >
> > Uhm, that doesn't compute...  If you don't put a space after sizeof,
> > the program won't compile.
> >
> > int c;
> > printf("%d", sizeofc);
>
> Uh, we prefer not to see "sizeof c".  IOW, we prefer to have the
> parentheses use all the time.  Maybe I need to say that better?

here's a *really* rough first pass, i'm sure the end result would need
some hand tweaking:

=============================================
#!/bin/sh

DIR=$1

#
#  Put in missing parentheses.
#

for f in $(grep -Erl "sizeof [^\(]" ${DIR}) ; do
  echo $f
  perl -pi -e "s/sizeof ([*]?[A-Za-z0-9_>\[\]\.-]+)( *)/sizeof\(\1\)\2/g" $f
done


#
#  Delete possible space between "sizeof" and "(".
#

for f in $(grep -rl "sizeof (" ${DIR}) ; do
  perl -pi -e "s/sizeof \(/sizeof\(/g" $f
done

#
#  Delete obnoxious spaces inside parentheses.
#

for f in $(grep -rl "sizeof( " ${DIR}) ; do
  perl -pi -e "s/sizeof\( *([^ \)]+) *\)/sizeof\(\1\)/g" $f
done
===========================================

rday
