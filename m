Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTEUXFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTEUXFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:05:48 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:32477 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262348AbTEUXFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:05:46 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Ingo Oeser" <ingo.oeser@informatik.tu-chemnitz.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: try_then_request_module
Date: Thu, 22 May 2003 00:18:49 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAGEGIDBAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030520093933.O659@nightmaster.csn.tu-chemnitz.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo.

 >>>    int module_loaded_flag=0;

 > Tell that we don't know, whether the module is loaded

 >>> retry_with_module_loaded:
 >>>    
 >>>    /* search code */

 > Do the search.    

 >>>    if (!module_loaded_flag && !found) {

 > Test, whether we did not yet explicitly load the module and not
 > found the entry either.

So if either we explicitly loaded the problem or we found it, the
test fails and we skip the entire body of that if statement.

Remember, if module_loaded_flag is non-zero then !module_loaded_flag
fails. Since you're using && and the link, !found isn't even tested
in that case.

 >>>       module_loaded_flag=1;

 > Tell that we loaded it (if we cannot load it, then we fall
 > through).

 >>>       if (!request_module(bla))
 >>>          goto retry_with_module_loaded;

 > Restart search after successful module load.

Doesn't happen - the logic on the if test at the top will always fail
and we'll just fall straight back down to just below this line.

 >>>    }
 >>>    return found;

 >> Out of curiosity, what exactly is the purpose of the goto in the
 >> above code? Since we set module_loaded_flag just prior to it, the
 >> first if statement must fail after the goto, so we just fall down
 >> to where we would have been without the goto.

 > That is intended. I just reuse the search code here instead of
 > duplicating it. 

It doesn't get reused though...

 > Since I load the module to broaden my search range, I can also
 > try to load the module there. Without module support this goto
 > will never execute and most of that code there compiled away.

True.

 > That's why I consider try_then_request_module() not needed.
 > But people seem to have big problems with using gotos and still
 > reading the code (although it's quite common in the kernel), so
 > try_then_request_module() might solve this *social* problem ;-)

Personally, I need a good reason for using goto's, more so than too
many of the kernel developers, and your code is a perfect example
of the reason why - the goto accomplishes absolutely nothing because
of the faulty logic in the if statement - but the faulty logic is
actually hidden by the goto in this case.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.483 / Virus Database: 279 - Release Date: 19-May-2003

