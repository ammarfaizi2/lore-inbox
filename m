Return-Path: <linux-kernel-owner+w=401wt.eu-S1030522AbXALEjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbXALEjt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbXALEjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:39:49 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:21929 "HELO
	smtp109.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030490AbXALEjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:39:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CyTSLEDc8Z1Zzc7K1ViWjrcSqdxvLkMcshdmBJlxc1xf9cVu3MFB/qlkb2ziitKNYh9iuFpvZnJjUGidsOxsGdYGkEyQ2TJxqXlpHZn6Q3LgrNHMnVUphlW9JalW45Py+dQoHubC0jxcFI/MHHsM4mg3qpcoeOtnKhHYOb+8enA=  ;
X-YMail-OSG: .WtG8XcVM1kOv_5iCUbxWdMjznVzbh4J8fOc48967oCFhJNI64X.jtg6OZoO1.ThWsxLDh4b4aphXWII.vUlMNlmpHF8SaITFMdfGIj0un1wJmscoyl0sfGZJq5tSagiDwl0du3D6wOxHA--
Message-ID: <45A710F8.7000405@yahoo.com.au>
Date: Fri, 12 Jan 2007 15:39:20 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/05] Linux Kernel Markers, non optimised architectures
References: <11685601382063-git-send-email-mathieu.desnoyers@polymtl.ca> <11685601404005-git-send-email-mathieu.desnoyers@polymtl.ca>
In-Reply-To: <11685601404005-git-send-email-mathieu.desnoyers@polymtl.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:

> +#define MARK(name, format, args...) \
> +	do { \
> +		static marker_probe_func *__mark_call_##name = \
> +					__mark_empty_function; \
> +		volatile static char __marker_enable_##name = 0; \
> +		static const struct __mark_marker_c __mark_c_##name \
> +			__attribute__((section(".markers.c"))) = \
> +			{ #name, &__mark_call_##name, format } ; \
> +		static const struct __mark_marker __mark_##name \
> +			__attribute__((section(".markers"))) = \
> +			{ &__mark_c_##name, &__marker_enable_##name } ; \
> +		asm volatile ( "" : : "i" (&__mark_##name)); \
> +		__mark_check_format(format, ## args); \
> +		if (unlikely(__marker_enable_##name)) { \
> +			preempt_disable(); \
> +			(*__mark_call_##name)(format, ## args); \
> +			preempt_enable_no_resched(); \

Why not just preempt_enable() here?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
