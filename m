Return-Path: <linux-kernel-owner+w=401wt.eu-S1751782AbWLMWw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWLMWw7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWLMWw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:52:59 -0500
Received: from terminus.zytor.com ([192.83.249.54]:46014 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbWLMWw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:52:58 -0500
Message-ID: <45807846.3010705@zytor.com>
Date: Wed, 13 Dec 2006 14:01:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Rudolf Marek <r.marek@assembler.cz>
CC: norsk5@xmission.com, lkml <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [RFC] new MSR r/w functions per CPU
References: <45807469.6040609@assembler.cz>
In-Reply-To: <45807469.6040609@assembler.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudolf Marek wrote:
> Hello all,
> 
> For my new coretemp driver[1], I need to execute the rdmsr on particular 
> processor.  There is no such "global" function for that in the kernel so 
> far.
> 
> The per CPU msr_read and msr_write are used in following drivers:
> 
> msr.c (it is static there now)
> k8-edac.c  (duplicated right now -> driver in -mm)
> coretemp.c (my new Core temperature sensor -> driver [1])
> 
> Question is how make an access to that functions. Enclosed patch does 
> simple EXPORT_SYMBOL_GPL for them, but then both drivers (k8-edac.c and 
> coretemp.c) would depend on the MSR driver. The ultimate solution would 
> be to move this type
> of function to separate module, but perhaps this is just bit overkill?
> 
> Any ideas what would be the best solution?
> 

For now I think you could just export these and allow the dependency. 
I've been meaning to rewrite the MSR and CPUID drivers to use a common 
core, which would also allow invoking nnostandard CPUID and msrs which 
need the entire register file to be set; that should probably be 
included in that.

In fact, I've made that change something like four times (it seems to be 
an airplane project that I never get around to submitting), so I should 
actually get it finished and sent in.

	-hpa
