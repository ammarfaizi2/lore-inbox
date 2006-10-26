Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945976AbWJZWzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945976AbWJZWzs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 18:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945973AbWJZWzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 18:55:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:25597 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1945976AbWJZWzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 18:55:47 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 3/13] KVM: kvm data structures
Date: Fri, 27 Oct 2006 00:55:45 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
References: <4540EE2B.9020606@qumranet.com> <20061026172456.91391A0209@cleopatra.q>
In-Reply-To: <20061026172456.91391A0209@cleopatra.q>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610270055.45560.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 October 2006 19:24, Avi Kivity wrote:
> +struct kvm {
> +       spinlock_t lock; /* protects everything except vcpus */
> +       int nmemslots;
> +       struct kvm_memory_slot memslots[KVM_MEMORY_SLOTS];
> +       struct list_head active_mmu_pages;
> +       struct kvm_vcpu vcpus[KVM_MAX_VCPUS];
> +       int memory_config_version;
> +       int busy;
> +};

Assuming that you move to the host-user == guest-real memory
model, will this data structure still be needed? It would
be really nice if a guest could simply consist of a number
of vcpu structures that happen to be used from threads in the
same process address space, but I find it hard to tell if
that is realistic.

	Arnd <><
