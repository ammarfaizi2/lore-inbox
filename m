Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWCXRWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWCXRWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 12:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWCXRWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 12:22:53 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:16367 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751258AbWCXRWw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 12:22:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qDCeJeu1yFF6MTG5jQfAYPgZPrd7ceC7djsgAgmO4so8OEnsWEELpcYG3LhEaOOPlrepea4aNMQVK1jK2GzUjshhL9Ldy68YhY2/f8YjWui7EEvfPNyGgs98UWSjTxVKvVi83qMiIHOwPM6fjgn2oHIHNMx5QotXrepkrgOZnJY=
Message-ID: <2c0942db0603240922u7bade58lcf2a6af2af8ec6ae@mail.gmail.com>
Date: Fri, 24 Mar 2006 09:22:51 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Subject: Re: delay_tsc(): inefficient delay loop (2.6.16-mm1)
Cc: lkml <linux-kernel@vger.kernel.org>, "john stultz" <johnstul@us.ibm.com>,
       "Dominik Brodowski" <linux@brodo.de>
In-Reply-To: <20060324170436.GA1568@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060324170436.GA1568@rhlx01.fht-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> +       loops += bclock;
[...]
> -       } while ((now-bclock) < loops);
> +       } while (now < loops);

Erm, aren't you introducing an overflow problem here?

if loops is 2^32-1, bclock is 1, the old version would execute the
proper number of times, the new one will blow out in one tick.
