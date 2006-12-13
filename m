Return-Path: <linux-kernel-owner+w=401wt.eu-S964842AbWLMKlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWLMKlS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 05:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbWLMKlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 05:41:17 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:3425 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932661AbWLMKlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 05:41:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RL9HHOk+afpRDUDZMDGY0JCc/CZ5rY3kiqiIRKbRLjCOaxQFhrWyd/vj7FvBg4j64djJmu5uIpGbfnmKjVeHtzyM8I6c2lA3Kb+GHS5FD7wo0nKk6cLHwzSyKHfoxRiJL5O8Z5w1X0wD6v7ZKuHxZVPC+VkoVctY4YkjPGY2oFI=
Message-ID: <b0943d9e0612130241k3363a2c9kd464d33122e6147f@mail.gmail.com>
Date: Wed, 13 Dec 2006 10:41:15 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Tejun Heo" <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: use piix_host_stop() in ich_pata_ops
Cc: "Jeff Garzik" <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061211132625.GA18947@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b0943d9e0612091454j6df1fb0ej2fa006c3fa33abae@mail.gmail.com>
	 <20061211132625.GA18947@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun,

On 11/12/06, Tejun Heo <htejun@gmail.com> wrote:
> piix_init_one() allocates host private data which should be freed by
> piix_host_stop().  ich_pata_ops wasn't converted to piix_host_stop()
> while merging, leaking 4 bytes on driver detach.  Fix it.

I tried your patch last night but the leak is still reported. I need
to investigate further and put some printk's in the piix_host_stop
function to check whether the freeing really takes place.

What I can't follow is where the ata_port_info.private_data
(port_info[] or ppinfo[]) in piix_init_one gets transfered to
ata_host.private_data (the "host" argument) that piix_host_stop tries
to free.

-- 
Catalin
