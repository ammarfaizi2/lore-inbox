Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUGZWGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUGZWGB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUGZWFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:05:51 -0400
Received: from main.gmane.org ([80.91.224.249]:48868 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266115AbUGZWEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:04:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Ballarin <Ballarin.Marc@gmx.de>
Subject: Re: [PATCH] Delete cryptoloop
Date: Mon, 26 Jul 2004 22:04:29 +0000 (UTC)
Message-ID: <loom.20040726T234406-216@post.gmane.org>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <1090672906.8587.66.camel@ghanima> <41039CAC.965AB0AA@users.sourceforge.net> <1090761870.10988.71.camel@ghanima> <4103ED18.FF2BC217@users.sourceforge.net> <1090778567.10988.375.camel@ghanima> <4104E2CC.D8CBA56@users.sourceforge.net> <1090845926.13338.98.camel@ghanima>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.139.231.36 (Mozilla/5.0 (compatible; Konqueror/3.2; Linux) (KHTML, like Gecko))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens-dated-1091709927.ed82 <at> endorphin.org> writes: 
 
> To summarize for an innocent bystander: 
>  
> - The attacks you brought forward are in the best case a starting point 
> for known plain text attacks. Even DES is secure against this attack, 
> since an attacker would need 2^47 chosen plain texts to break the cipher 
> via differential cryptanalysis. (Table 12.14 Applied Cryptography, 
> Schneier). First, the watermark attack can only distinguish 32 
> watermarks. Second, you'd need a ~2.000.000 GB to store 2^47 chosen 
> plain texts. Third, I'm talking about DES (designed 1977!), no chance 
> against AES. 
>  
 
>From what I understand now, this exploit is solely based on the weakness of 
dm-crypt's/cryptoloops IV generation. 
 
The difference in bit patterns between the first and second half of the 
watermark block compensates partly for the trivially and predictably changing 
IV beetween two successive sectors.  
As Jari eplained, this causes *any* cipher to produce two identical blocks of 
ciphertext (after all the input is identical). 
This is also, why this exploit requires a minimum filesystem block size of 1kB 
for good reliability. 
 
> - The weaknesses brought forward by me are summarized  at 
> http://clemens.endorphin.org/OnTheProblemsOfCryptoloop . Thanks goes to 
> Pascal Brisset, who pointed out that cryptoloop is actually more secure 
> than I assumed. 
>  
 
If my understanding is correct, an improved and unpredictable IV generation - 
- as needed anyway for the vulnerability described at 
http://clemens.endorphin.org/OnTheProblemsOfCryptoloop - 
*should* protect against this watermarking as well. So both problems can be 
fixed together and rather easily. 
 
Regards 
 

