Return-Path: <linux-kernel-owner+w=401wt.eu-S1423137AbWLUXsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423137AbWLUXsL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423136AbWLUXsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:48:11 -0500
Received: from web55606.mail.re4.yahoo.com ([206.190.58.230]:43083 "HELO
	web55606.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1423139AbWLUXsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:48:10 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 18:48:10 EST
Message-ID: <20061221234127.29189.qmail@web55606.mail.re4.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=0Rfm+TLMnWoMjzoURlJhenQTGiyymLYb84xryyuD9hC4vMLUke9Okw0sOnLYbRs1lnss9p/FgxokdjqoDCERwvHfSR3Q60+b7itzAMmr9EcafsE5WJbyXR/YBIIBFy80Ki7XFmsjTXjay/YQVTswYMRWRKBNl/UeBiEDQRUPTKg=;
X-YMail-OSG: N4lh8lsVM1n6PQnbOjqsws_VTJrCmgb.K2cF8EU4FY4M4tW7TyUFhIlWJ1wjhdsacXTktXRqBIUQcOfwQOq9F3OK7fsBg2HwadnRw3qkdDWSzT7a1jKCABrYbLHb_aR_nLTmrglsH9GPCh8-
Date: Thu, 21 Dec 2006 15:41:27 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Was just wondering if the _var_ in kfree(_var_) could be set to NULL after its freed. It may solve
the problem of accessing some freed memory as the kernel will crash since _var_ was set to NULL.

Does this make sense? If yes, then how about renaming kfree to something else and providing a
kfree macro that would do the following:

#define kfree(x) do { \
                      new_kfree(x); \
                      x = NULL; \
                    } while(0)

There might be other better ways too.

Regards,
Amit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
