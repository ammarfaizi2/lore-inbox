Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWBSRGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWBSRGk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWBSRGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:06:39 -0500
Received: from relay4.usu.ru ([194.226.235.39]:44177 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S932163AbWBSRGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:06:38 -0500
Message-ID: <43F8A5BD.3020108@ums.usu.ru>
Date: Sun, 19 Feb 2006 22:07:09 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: "Adam Tla/lka" <atlka@pg.gda.pl>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <20060218025921.7456e168.akpm@osdl.org> <43F744C6.8020209@pg.gda.pl> <43F7F2FA.2060102@ums.usu.ru> <20060219161643.GA15459@sunrise.pg.gda.pl>
In-Reply-To: <20060219161643.GA15459@sunrise.pg.gda.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.1.0; VDF: 6.33.1.5; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Tla/lka wrote:
> On Sun, Feb 19, 2006 at 09:24:26AM +0500, Alexander E. Patrakov wrote:
>   
>> Adam Tlałka wrote:
>>
>>     
>>> Maybe I should remember all bytes of the UTF-sequence to use their 
>>> values as a last resort char in case of malformed sequence and 0xfffd
>>> not defined?
>>>       
>> Please don't do that. Display question marks instead in the case when 
>> 0xfffd is not defined.
>>     
>
> Look at the original code. If conv_uni_to_pc fails and there is no replacement
> char (after a clear_unimap for example) and we using US-ASCII we rather
> should see something then sequences of '?' chars.
> Maybe I could change this to:
>
> if (tc == -4) {
> 	if (c < 128)
> 		tc = c;
> 	else
> 		tc = '?';
> }
>
> What about that?
>   
I'd let someone else judge, but that is clearly a broken case that just 
has to be declared broken. <joke>could you please also adapt to a font 
that has all glyphs looking as smileys?</joke> But it's only three extra 
lines of code, so let's accept that "c<128" check.
> Remembering of original bytes is needed if we could then remember
> them in a way so paste from screen gives us the same sequence as it was
> in input.
This doesn't match the behaviour of X.
>  With current console design it is impossible is case
> of correct UTF-8 sequences containing undisplayable glyphs or malformed
> sequences.
I agree that, in some cases, it makes sense to copy and paste 
undisplayable glyphs. However, IMHO, this should not be allowed for 
malformed sequences.

-- 
Alexander E. Patrakov

