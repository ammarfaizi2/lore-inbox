Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVFKAca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVFKAca (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 20:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFKAc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 20:32:29 -0400
Received: from smtp06.auna.com ([62.81.186.16]:17286 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261487AbVFKAcY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 20:32:24 -0400
Date: Sat, 11 Jun 2005 00:32:22 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc6-mm1
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <20050607170853.3f81007a.akpm@osdl.org>
	<200506110019.13204.kernel@kolivas.org>
	<1118445260l.7785l.0l@werewolf.able.es>
	<200506110959.53614.kernel@kolivas.org>
In-Reply-To: <200506110959.53614.kernel@kolivas.org> (from
	kernel@kolivas.org on Sat Jun 11 01:59:50 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1118449942l.11603l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.215.85] Login:jamagallon@able.es Fecha:Sat, 11 Jun 2005 02:32:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.11, Con Kolivas wrote:
> 
> Here is what the patch _should_ have been. (*same warnings with this patch 
> about math demonstration and untested as should have been posted with the 
> earlier one*)
> 
> +	if (idle == NOT_IDLE || rq->nr_running > 1) {
> +		unsigned long prio_bias = 1;
> +		if (rq->nr_running)
> +			prio_bias = rq->prio_bias / rq->nr_running;
> +		source_load *= prio_bias;
> +	}
>  

Again... sorry, I don't try to be picky, just want to know if its worth or
not...

Would not be better something like:

	if (idle == NOT_IDLE || rq->nr_running > 1) {
		if (rq->nr_running)
			source_load = (source_load*rq->prio_bias) / rq->nr_running;
	}
  
wrt the integer math ? Think of

100*( 5/5) vs  500/5
100*( 6/5) vs  600/5
100*( 7/5) vs  700/5
100*( 8/5) vs  800/5
100*( 9/5) vs  900/5
100*(10/5) vs 1000/5

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam24 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


