Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758204AbWK0NkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758204AbWK0NkT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 08:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758206AbWK0NkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 08:40:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23696 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1758204AbWK0NkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 08:40:17 -0500
Date: Mon, 27 Nov 2006 13:39:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 19/38] KVM: Make __set_efer() an arch operation
Message-ID: <20061127133944.GA4155@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Avi Kivity <avi@qumranet.com>, kvm-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com> <20061127122938.0518325015E@cleopatra.q>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127122938.0518325015E@cleopatra.q>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 12:29:38PM -0000, Avi Kivity wrote:
>  #ifdef __x86_64__
> -	__set_efer(vcpu, sregs->efer);
> +	kvm_arch_ops->set_efer(vcpu, sregs->efer);
>  #endif

I think it would be much better to make ->set_efer a noop for 32bit,
and have different operation vectors for 32 vs 64 bit.

>  #ifdef __x86_64__
> -	__set_efer(vcpu, 0);
> +	vmx_set_efer(vcpu, 0);
>  #endif

Similarly vmx_set_efer should just become a noop on 32bit.
