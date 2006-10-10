Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWJJHbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWJJHbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWJJHbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:31:24 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:9144 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965074AbWJJHbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:31:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hreg7RreyyYOhX4wH05ZFponv5sSVhZyM1VWd3vzer88qZ0dda3Ch+nB8q6+57uppsVwjIXsxlrK0KCRMacrLjBRv0FHT/teMT6oc6WpqkyQnwNA/e/qIihvV7lNzay2vILS10LSeTHBx5QRlKlBGvpzOvFohxeKWt1zEYRe8PY=
Message-ID: <653402b90610100031i5132083ewba1240d01981f4ae@mail.gmail.com>
Date: Tue, 10 Oct 2006 07:31:23 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19-rc1-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061010000928.9d2d519a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/06, Andrew Morton <akpm@osdl.org> wrote:
>
> +# drivers-add-lcd-support.patch: Pavel says use fbcon
> +drivers-add-lcd-support.patch
> +drivers-add-lcd-support-update.patch
>

Has the # a special meaning?

I'm going to work on offering the fbcon feature as Pavel requested. We
suggested 2 ways.

Pavel's idea: Change the driver so the cfag12864b module will be just
a framebuffer device, removing access through /dev/cfag12864b.

My idea: Code a new module called "fbcfag12864b", which will depend on
cfag12864b and will be the framebuffer device. This way we have both
devices, and they doesn't affect each other as they are different
things. So the ks0108 and cfag12864b can stay without any changes.
Also, if we finally decide we don't want the raw cfag12864b module, it
is easy to remove it from the cfag12864b and the fbcafg12864b will
continue working.

Is there anyone who can decide which idea is better? If not, I will
code it my way. Also, if the Pavel's idea will be the chosen one, it
will be easier to put the fbcfag12864b code into the cfag12864b rather
than the opposite.
