Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161346AbWJKTJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbWJKTJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161343AbWJKTJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:09:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:13613 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161346AbWJKTIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:08:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WTbnlmMsel+td4EFJ4xSf8c91gZRtCqKQWwUFDbnSPVh6gRFuyYvIEeidEMf3FhxCFe3JgCnONVX9+QIGidF8GiR9nBVl/pCrMLbg4bfGoChGHujIQsjUY0RnBgUr6eJG6vxJ5/bi9PE2ByvYVDqfl5dCIpNd6r39xYgFVmvMTo=
Message-ID: <b6fcc0a0610111208s4dbb7c98xbdd3ceb13fba1503@mail.gmail.com>
Date: Wed, 11 Oct 2006 23:08:52 +0400
From: "Alexey Dobriyan" <adobriyan@gmail.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: misused local_irq_disable() in analog.c?
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry, take a look at analog_cooked_read():

do-while loop there contains local_irq_disable()/local_irq_restore(flags);
which aren't complement.

Should it be

    local_irq_save(flags);
    this = gameport_read(gameport) & port->mask;
    GET_TIME(now);
    local_irq_restore(flags);

?
