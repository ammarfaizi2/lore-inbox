Return-Path: <linux-kernel-owner+w=401wt.eu-S1752491AbWLQL6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbWLQL6u (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 06:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbWLQL6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 06:58:50 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:52309 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbWLQL6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 06:58:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n25z5pCWN2sE5sHUikBzThtc5PmbWRYewytsX46/jgeSX/lOSOTemp+xiWjxyh+TFFbYY9nm0JlEQEQ81IwclK0EquO6gLfMM8/36B5SedODs9DpkT5r/73uX90UHtrERu/wL3jiPJYrgkL/8NmMcxmJaSzJNka6hH72PciDaVI=
Message-ID: <b0943d9e0612170358r2b1ff36bi31270806b5ce1b53@mail.gmail.com>
Date: Sun, 17 Dec 2006 11:58:49 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061217092828.GA14181@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <20061216165738.GA5165@elte.hu>
	 <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
	 <20061217085859.GB2938@elte.hu> <20061217090943.GA9246@elte.hu>
	 <20061217092828.GA14181@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> one more thing: after bootup i need to access the /debug/memleak file
> twice to get any output from it - is that normal? The first 'cat
> /debug/memleak' gives no output (but there's the usual scanning delay,
> so memleak does do its work).

Yes, this is normal. Especially on SMP, I get some transient reports,
probably caused by pointers hold in registers (even more visible on
ARM due to the bigger number of registers per CPU). Reporting a leak
only if it was seen at least once before greatly reduces the false
positives (this is configurable as well but I'll drop the
configuration option). Without this, you could see that, at every
scan, the reported pointers are different.

Some people testing kmemleak used to read the /debug/memleak file
periodically from a script and this wasn't noticeable. It would be
even better if, as you suggested, I schedule a periodic memory
scanning.

-- 
Catalin
