Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVC3Sa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVC3Sa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVC3Saz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:30:55 -0500
Received: from main.gmane.org ([80.91.229.2]:2477 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262376AbVC3Sav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:30:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Shankar Unni <shankarunni@netscape.net>
Subject: Re: Do not misuse Coverity please
Date: Wed, 30 Mar 2005 10:29:43 -0800
Message-ID: <d2er4p$qp$1@sea.gmane.org>
References: <200503300125.j2U1PFQ9005082@laptop11.inf.utfsm.cl> <OofSaT76.1112169183.7124470.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-68-122-224-119.dsl.pltn13.pacbell.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6) Gecko/20050317 Thunderbird/1.0.2 Mnenhy/0.7
X-Accept-Language: en-us, en
In-Reply-To: <OofSaT76.1112169183.7124470.khali@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:

>     v = p->field;
>     if (!p) return;
> 
> can be seen as equivalent to
> 
>     if (!p) return;
>     v = p->field;

Heck, no.

You're missing the side-effect of a null pointer dereference crash (for 
p->field) (even though v is unused before the return). The optimizer is 
not allowed to make exceptions go away as a result of the hoisting.

