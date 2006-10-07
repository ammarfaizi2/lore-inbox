Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbWJGHSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWJGHSa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 03:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWJGHSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 03:18:30 -0400
Received: from smtpout.mac.com ([17.250.248.181]:10449 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932698AbWJGHS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 03:18:29 -0400
In-Reply-To: <1160123182.26064.140.camel@pmac.infradead.org>
References: <200609150901.33644.ismail@pardus.org.tr> <200610011034.57158.ismail@pardus.org.tr> <20061001091411.GA9647@uranus.ravnborg.org> <200610051116.12726.ismail@pardus.org.tr> <1160123182.26064.140.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E97C1F9B-36B7-43F8-A472-160754AB8139@mac.com>
Cc: Ismail Donmez <ismail@pardus.org.tr>, Sam Ravnborg <sam@ravnborg.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       mchehab@infradead.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: __STRICT_ANSI__ checks in headers
Date: Sat, 7 Oct 2006 03:17:55 -0400
To: David Woodhouse <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 06, 2006, at 04:26:22, David Woodhouse wrote:
> On Thu, 2006-10-05 at 11:16 +0300, Ismail Donmez wrote:
>> The problem shows itself in the modpost, somehow __extension__  
>> clause seems to  foobar module CRC. I am not yet successfull on  
>> making modpost ignore
>> __extension__ .
>>
>> Any ideas appreciated.
>
> Something like this (and build with GENERATE_PARSER=1) _ought_ to  
> do it,
> but doesn't work:
>
> @@ -269,7 +270,7 @@ cvar_qualifier_seq:
>
>  cvar_qualifier:
>  	CONST_KEYW | VOLATILE_KEYW | ATTRIBUTE_PHRASE
> -	| RESTRICT_KEYW
> +	| RESTRICT_KEYW | EXTENSION_KEYW
>  		{ /* restrict has no effect in prototypes so ignore it */
>  		  remove_node($1);
>  		  $$ = $1;

Well it's actually technically not a cvar_qualifier; it's a pseudo- 
arbitrarily attached keyword that can be stuck on any number of GCC- 
only constructs, like nested code: "__extension__ ({ foo(); 1; })"  
for example.

Probably the simplest thing to do is actually to just convert it into  
a nonexistent or whitespace token, or if there's a preprocessing step  
just #define it to the empty string.

Cheers,
Kyle Moffett

