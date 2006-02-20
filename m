Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWBTRjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWBTRjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWBTRjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:39:41 -0500
Received: from dvhart.com ([64.146.134.43]:1700 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1161077AbWBTRjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:39:40 -0500
Message-ID: <43F9FEDA.3030205@mbligh.org>
Date: Mon, 20 Feb 2006 09:39:38 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] some fixups for the X86_NUMAQ dependencies
References: <20060219232621.GC4971@stusta.de> <43F9EF43.3020709@mbligh.org> <20060220170827.GD4661@stusta.de>
In-Reply-To: <20060220170827.GD4661@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>config X86_NUMAQ
>>>	bool "NUMAQ (IBM/Sequent)"
>>>+	select SMP
>>>	select NUMA
>>>	help
>>>	  This option is used for getting Linux to run on a (IBM/Sequent) 
>>>	  NUMA
>>>@@ -419,6 +420,7 @@
>>
>>Surely NUMA should select SMP, not NUMA-Q?
> 
> NUMA depends on SMP.
> 
> Therefore, if you select NUMA, you have to ensure that SMP is enabled.

Yes. but that should link SMP -> NUMA -> NUMA-Q, not SMP directly to 
NUMA-Q, surely?

> NUMAQ can't be hidden since it doesn't has any dependencies.
> And this isn't what this comment is talking about (note the the 
> comment is only shown if NUMAQ was already select'ed).
> 
> NUMAQ didn't fulfill the contract that when select'ing NUMA, it has to 
> ensure the dependencies of NUMA are fulfilled. My patch solves this 
> properly instead of telling the user through a comment that he ran into 
> this bug.

Yes, if that works, it's much cleaner. Perhaps we just had insufficient
config-fu to figure it out ... it looks good - I suppose I'd better test 
it, and make sure we don't hit the same thing we did before.

m.
