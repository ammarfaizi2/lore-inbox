Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756834AbWKWGQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbWKWGQL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 01:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755322AbWKWGQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 01:16:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:60795 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756834AbWKWGQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 01:16:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=QjN9So6efhfOBKpH4+QpJXhiATRmOdnNwm8pUDGYzOf9k8EV6GVH83kKyPlxizy1ga1j5ipYDo3aVsFCkwOzcwQZ3JQPpfB5OEe5hqNZ6QckMg9tOIntf+iScaFqVzBmtk7dVrpAfRIhOB8YrRnbPm+NWKMv5vLH/wFKye33fqQ=
Message-ID: <86802c440611222216u629835fepe2a39d4d34d9fefb@mail.gmail.com>
Date: Wed, 22 Nov 2006 22:16:07 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Auke Kok" <auke-jan.h.kok@intel.com>
Subject: Re: [PATCH 4/5] e1000 : Make Intel e1000 driver legacy I/O port free
Cc: "Matthew Wilcox" <matthew@wil.cx>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Hidetoshi Seto" <seto.hidetoshi@jp.fujitsu.com>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, "Greg KH" <greg@kroah.com>,
       "Grant Grundler" <grundler@parisc-linux.org>,
       "Andrew Morton" <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       "Kenji Kaneshige" <kaneshige.kenji@jp.fujitsu.com>
In-Reply-To: <456476B0.70705@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4564050C.70607@jp.fujitsu.com>
	 <1164185809.31358.714.camel@laptopd505.fenrus.org>
	 <20061122135423.GV18567@parisc-linux.org> <456476B0.70705@intel.com>
X-Google-Sender-Auth: eab1d930b78e3d4f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/06, Auke Kok <auke-jan.h.kok@intel.com> wrote:
> I think we want to condense the USE_IOPORT flag together with the other hardware

two cases
1. the IO port is not allocated by firmware, but
pci_assign_unassigned_resources will get that allocated.
2. the IO port is allocated by firmware, the bar will be retrieved by
pcibios_resource_survey.

so acctully the device already get the bar allocated in any case.

So what the purpose of this patch? the /poc/ioports hide ioport for the driver?

It seems need to add some pci_quirk to clear the bar for 2, and skip
the resource allocation for 1.

YH
