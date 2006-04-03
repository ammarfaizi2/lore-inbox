Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWDCLxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWDCLxM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 07:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWDCLxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 07:53:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:65482 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964797AbWDCLxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 07:53:10 -0400
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Date: Mon, 3 Apr 2006 13:49:02 +0200
User-Agent: KMail/1.9.1
Cc: Christoph Lameter <clameter@sgi.com>, sonny@burdell.org, ak@suse.com,
       akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20060402213216.2e61b74e.akpm@osdl.org> <Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com> <20060402221513.96f05bdc.pj@sgi.com>
In-Reply-To: <20060402221513.96f05bdc.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604031349.03036.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 April 2006 07:15, Paul Jackson wrote:
> -		for (cpu = 0; cpu < NR_CPUS; cpu++) {
> +		for_each_online_cpu(cpu) {
> 
> Idle curiosity -- what keeps a cpu from going offline during
> this scan, and leaving us with the same crash as before?


CPU hotdown uses RCU like techniques to avoid this. Only potential
problem could be on a preemptive kernel, but I hope nobody tries
cpu unplug on such a beast. The later could be probably fixed
with a rcu_read_lock() or somesuch.

-Andi
