Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbWJKURf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbWJKURf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbWJKURf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:17:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:63531 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161224AbWJKURe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:17:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Ur1fpv+H8XLDkIIy4HL5v6W6NDxvYi499rK20XEsQoNCaTqMPwPjrbiwQFOdXQHEztXa8BgkNEr/0gPB8o//yZfKxs3xVZ4Wiq49+Ix82j4CuDPEO27vNneIcD6Q6JMWld7sv/nHJZlN8Oc/5N2q9Hf0/xxRqCqugVhrr9hwmDA=
Message-ID: <d120d5000610111317k4e849707rc358fdd4ad5dae5b@mail.gmail.com>
Date: Wed, 11 Oct 2006 16:17:33 -0400
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: Re: misused local_irq_disable() in analog.c?
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <b6fcc0a0610111208s4dbb7c98xbdd3ceb13fba1503@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6fcc0a0610111208s4dbb7c98xbdd3ceb13fba1503@mail.gmail.com>
X-Google-Sender-Auth: 6313e10ba7fb2a6d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> Dmitry, take a look at analog_cooked_read():
>
> do-while loop there contains local_irq_disable()/local_irq_restore(flags);
> which aren't complement.
>
> Should it be
>
>    local_irq_save(flags);
>    this = gameport_read(gameport) & port->mask;
>    GET_TIME(now);
>    local_irq_restore(flags);
>
> ?

Yep, I think so. Patch?

-- 
Dmitry
