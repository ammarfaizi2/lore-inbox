Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424377AbWKQNn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424377AbWKQNn1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424383AbWKQNn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:43:27 -0500
Received: from web23114.mail.ird.yahoo.com ([217.146.189.54]:24679 "HELO
	web23114.mail.ird.yahoo.com") by vger.kernel.org with SMTP
	id S1424377AbWKQNn0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:43:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xmh72roviGbqGS1dQ6SgGQVMiEGQO2WGc7qviXr067cBV32ZxXtf7YYNSKFE3NqSuQiiJtqmj8mfWaQUlXfDRFnLyJqj3cOlOKj+Ar3XTqAmxooeoSYUeMZ4NF4Wz3Rw4wDWD9ztHbyFA5J8naRuHbwguFJV9nP6GlNfj52vDKU=  ;
Message-ID: <20061117134325.62026.qmail@web23114.mail.ird.yahoo.com>
Date: Fri, 17 Nov 2006 13:43:25 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : vm: weird behaviour when munmapping
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Fri, 2006-11-17 at 12:50 +0000, moreau francis wrote:
>>
>> lower vma: 0x2aaae000 -> 0x2aaaf000
>> upper vma: 0x2aaaf000 -> 0x2aab2000
> 
> that is the remaining VMA, not the new one; we trigger this code:
> 
>     /* Does it split the last one? */
>     last = find_vma(mm, end);
>     if (last && end > last->vm_start) {
>         int error = split_vma(mm, last, end, 1);
>         if (error)
>             return error;
>     }
> 
> So, since its the last VMA that needs to be split (there is only one),
> the new VMA is constructed before the old one. Like so:
> 
>   AAAAAAAAAAAAAAAAAAAAA
>   BBBBAAAAAAAAAAAAAAAAA
> 
> Then you proceed closing, in this case the new one: B.

Sorry but I don't understand why B is said to be the new one. OK
I can see why from the bit of code you pointed out but from a
logical point of view (ok maybe be me only) I'm unmapping 'BBBB'
segment, so 'BBBB' is going to be destroyed and therefore A is
the new one. Thereferore I would expect close(B), open(A)...

no ?

Francis






	

	
		
___________________________________________________________________________ 
Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! 
Profitez des connaissances, des opinions et des expériences des internautes sur Yahoo! Questions/Réponses 
http://fr.answers.yahoo.com
