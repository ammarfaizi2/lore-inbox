Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbVIONCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbVIONCL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbVIONCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:02:11 -0400
Received: from web51002.mail.yahoo.com ([206.190.38.133]:29581 "HELO
	web51002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030392AbVIONCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:02:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SPDrL7/EbcGGQRqh+A4cvKkvaKCfcS3oSafnswDMrB+zXQKC7gIIc6E46jHw2bXxxsedVEv9jZwQL117lVEI6WdrdmcITRaLFa9rOX9/1juzVBnwIMCrQsxquMX8H02Jw30rt7wvTChWhtn4VYIJG1iEwzj7t/BeRZOR+0MEDrc=  ;
Message-ID: <20050915130201.95797.qmail@web51002.mail.yahoo.com>
Date: Thu, 15 Sep 2005 06:02:01 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic Configuration of a Kernel
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <432962B1.6040302@cs.aau.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Emmanuel Fleury <fleury@cs.aau.dk> wrote:

> Hi,
> 
> Roman Zippel wrote:
> > 
> > The basic problem is that maintaining the bulk of
> autoconfig information 
> > in a separate file is not feasible, it would be a
> nightmare to maintain.
> > This means it would be better to integrate this
> information into Kconfig 
> > and define interface so that external
> program/scripts (preferably shell 
> > instead of perl) can use that to configure the
> kernel.
> > 
> > A simple example could look like this:
> > 
> > config FOO
> > 	bool "foo"
> > 	def_auto y
> 
> Why not directly having a direct reference to the
> name of the script ?
> 
> config FOO
> 	bool "foo"
> 	auto "detect-foo-script"
> 
> Where you have a specific directory in
> scripts/autoconfig/ where you
> store the scripts. Each script output y, n or m.
> 
> But, it means a hell of scripts (except if we can
> pass arguments in the
> auto field: auto "detect-foo-script card-XYZ
> release-32-or-higher").

To pass argument it is not a problem we do it like we
passed the rules in the rules_list(see the function
exec_rule in auto_conf.c ). The lex parser has to be
expanded in that way that it gives everything written
after "auto" to the autoconfig.

 config FOO
 	bool "foo"
 	auto "detect-foo-script" 

So the new programm will work like that:

It goes through are the Kconfig as usual. For any
Option that doesn't have any "auto" a '\n' will be
given. If there is an "auto" it will execute the
script that is written after it. I think it might work
like that. Any suggestion?? 




> This scheme seems much simpler to me (and yet not
> restrictive at all).
> Of course, each script might have to ask few
> questions to the user as:
> Do you want this FOO support ? [y/m/n]:
> 
> Or (when no module option):
> Do you want this FOO support ? [y/n]:

If the script want to ask some question, what will be
the difference if we write make config.



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
