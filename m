Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUGXNuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUGXNuK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 09:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268604AbUGXNuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 09:50:10 -0400
Received: from main.gmane.org ([80.91.224.249]:25774 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265237AbUGXNuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 09:50:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Ballarin <Ballarin.Marc@gmx.de>
Subject: Re: Interesting race condition...
Date: Sat, 24 Jul 2004 13:40:59 +0000 (UTC)
Message-ID: <loom.20040724T152713-574@post.gmane.org>
References: <200407222204.46799.rob@landley.net> <20040723073300.GA4502@ip68-4-98-123.oc.oc.cox.net> <200407240313.19053.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.139.250.169 (Mozilla/5.0 (compatible; Konqueror/3.2; Linux) (KHTML, like Gecko))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <rob <at> landley.net> writes: 
 
> Oh I can't reproduce it either.  (Maybe if I set some kind of loop and left 
> it running for a few days...) 
 
I could reproduce it on an otherwise idle system (2 GHz Athlon, kernel 2.6.7). 
On a loaded system the bug did not occur, which certainly indicates a race 
condition. 
 
Using the following Bash script, the bug appeared 23 times in 122,221 
iterations: 
while [ 1 ];do 
        ps ax | grep hack >> TEST 
done 
 
The bug *seems* to be in bash, since an equivalent script in tcsh had no 
problems: 
while ( 1 ) 
        ps ax | grep hack >> TEST2 
end 
 
This issue has the potential to break a lot of shell scripts in an almost 
undebugable way. Should someone file a bug report via 'bashbug'? 
 
Marc 

