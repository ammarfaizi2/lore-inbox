Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbSJIOtW>; Wed, 9 Oct 2002 10:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbSJIOtW>; Wed, 9 Oct 2002 10:49:22 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:36085 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261755AbSJIOtV>; Wed, 9 Oct 2002 10:49:21 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021009144414.GZ26771@phunnypharm.org> 
References: <20021009144414.GZ26771@phunnypharm.org>  <20021009.045845.87764065.davem@redhat.com> <18079.1034115320@passion.cambridge.redhat.com> <20021008.175153.20269215.davem@redhat.com> <200210091149.g99BnWQ5000628@pool-141-150-241-241.delv.east.verizon.net> <7908.1034165878@passion.cambridge.redhat.com> <3DA4392B.8070204@pobox.com> 
To: Ben Collins <bcollins@debian.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: BK kernel commits list 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-9483239040"
Date: Wed, 09 Oct 2002 15:55:00 +0100
Message-ID: <27367.1034175300@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-9483239040
Content-Type: text/plain; charset=us-ascii


bcollins@debian.org said:
>  Just please make sure that the changeset info where it describes all
> the files in the delta. I.e. the ones that are moved, deleted, new.
> There's no way to deduce moves from the patch. 

This bit?

# This patch includes the following deltas:
#                  ChangeSet    1.713   -> 1.714
#       arch/i386/math-emu/poly.h       1.3     -> 1.4
#

Any idea how to get it other than 'bk export -tpatch | sed' ?

I need to do some real work... play with ths script and sort it out between 
yourselves :)


--
dwmw2


--==_Exmh_-9483239040
Content-Type: application/x-sh ; name="mailcset.sh"
Content-Description: mailcset.sh
Content-Disposition: attachment; filename="mailcset.sh"

#!/bin/sh
# $Id: mailcset.sh,v 1.6 2002/10/09 14:53:29 dwmw2 Exp $

CSET=$1

# Hmmm. How to get just the first line in a dspec without 'head -1'?
echo -n "Subject: " ; bk changes -r$CSET -d'$each(:C:){(:C:)\n}' | head -1

# Grrr. bk prs needs an 'rfc822 datestamp' keyword.
DATE="`bk changes -r$CSET -d':D: :T: :TZ: \n' | sed 's/\([+-]..\):/\1/'`"
# How can I preserve timezone information?
echo -n "Date: " ; date -d "$DATE" -R -u
echo "X-BK-Repository: `hostname`:`pwd`"
echo "X-BK-ChangeSetKey: `bk changes -r$CSET -d:CSETKEY:`"
echo "From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>"
echo "To: BK Commits List: ;"
echo
bk changes -r$CSET -d':G: :I:, :D: :T::TZ:, :USER:@:HOST:\n\n$each(:C:){\t(:C:)\n}'
echo
echo
bk export -h -tpatch -r$CSET > ~/tmp/bkpatch.$$
diffstat < ~/tmp/bkpatch.$$
echo
echo
cat ~/tmp/bkpatch.$$
rm ~/tmp/bkpatch.$$

--==_Exmh_-9483239040--


