Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318269AbSGXIMQ>; Wed, 24 Jul 2002 04:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318273AbSGXIMQ>; Wed, 24 Jul 2002 04:12:16 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.149]:13294 "EHLO
	moutvdomng2.kundenserver.de") by vger.kernel.org with ESMTP
	id <S318269AbSGXIMP>; Wed, 24 Jul 2002 04:12:15 -0400
Date: Wed, 24 Jul 2002 02:15:19 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DocBook - kernel-doc error messages
In-Reply-To: <20020723211424.A9242@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0207240214490.3200-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 Jul 2002, Sam Ravnborg wrote:
> Use of uninitialized value in string ne at scripts/kernel-doc line 641, <IN> line 247.
> Use of uninitialized value in string ne at scripts/kernel-doc line 661, <IN> line 247.
> Use of uninitialized value in join or string at scripts/kernel-doc line 363, <IN> line 247.

This one fixes it for me:

--- linus-2.5/scripts/kernel-doc	2002-07-16 10:02:12.000000000 -0600
+++ thunder-2.5/scripts/kernel-doc	2002-07-24 02:13:54.000000000 -0600
@@ -638,6 +638,7 @@
     print "  <programlisting>\n";
     print $args{'type'}." ".$args{'struct'}." {\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
+	defined($args{'parameterdescs'}{$parameter}) || next;
         ($args{'parameterdescs'}{$parameter} ne $undescribed) || next;
 	$type = $args{'parametertypes'}{$parameter};
 	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
@@ -658,6 +659,7 @@
 
     print "  <variablelist>\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
+      defined($args{'parameterdescs'}{$parameter}) || next;
       ($args{'parameterdescs'}{$parameter} ne $undescribed) || next;
       print "    <varlistentry>";
       print "      <term>$parameter</term>\n";

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

