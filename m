Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUAPRKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 12:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUAPRKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 12:10:36 -0500
Received: from ms-smtp-02-smtplb.ohiordc.rr.com ([65.24.5.136]:31481 "EHLO
	ms-smtp-02-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S263475AbUAPRKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 12:10:32 -0500
Message-ID: <40081AF0.5060907@borgerding.net>
Date: Fri, 16 Jan 2004 12:10:08 -0500
From: Mark Borgerding <mark@borgerding.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
References: <Xine.LNX.4.44.0401161039480.20623-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0401161039480.20623-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:

>On Fri, 16 Jan 2004, Mark Borgerding wrote:
>
>  
>
>> From looking through the cryptoloop code, it looks like the IV for CBC
>>mode is always the sector index.  It seems this could be weak against
>>chosen plaintext attacks, as well as allowing an attacker to know which
>>cipher blocks started any changes between two snapshots of the
>>ciphertext.  I discuss ECB, since I wouldn't consider using it.
>>    
>>
>
>Eli Biham has suggested encrypting the sector numbers, see
>http://people.redhat.com/jmorris/crypto/cryptoloop_eli_biham.txt
>
>
>
>- James
>  
>

This does not defend against a dictionary attack.

The IV is still deterministic for a given sector and hypothesized 
password. 
Thus the ciphertext for a given plaintext at that sector is still 
deterministic.

Thinking of it another way, this is equivalent to CBC mode having two 
IVs: the first one being the sector number, the second a block of zeros.


- Mark

