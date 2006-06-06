Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWFFQKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWFFQKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWFFQKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:10:41 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:5173 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751045AbWFFQKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:10:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eN6ZzhzO1puMZjEzEoV64GuwuAosH3jE+UW4ofb+7GikeVfp0KCbpDDeDKqyVmhaDSx0OtJGT1dgrQwmX0dlgZZ3GrUYyTAet+UZpoDQ6qXNd6L9Dps1ek75bFn9Hy7IKKCTIqwcqFHjRD+Mu4KrLjOJUIu/CUvwlkY+bsTuk4k=
Message-ID: <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>
Date: Tue, 6 Jun 2006 12:10:40 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/7] Detaching fbcon
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <44856223.9010606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44856223.9010606@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Overall, this feature is a great help for developers working in the
> framebuffer or console layer.  There is not need to continually reboot the
> kernel for every small change. It is also useful for regular users who wants
> to choose between a graphical console or a text console without having to
> reboot.

Instead of the sysfs attribute, what about creating a new escape
sequence that you send to the console system to detach? Doing it that
way would make more sense from a stacking order. It just seems
backwards to me that you ask a lower layer to detach from the layer
above it. The escape sequence would also work for any console
implementation, not just fbcon.

If console detached this way and there was nothing to fallback to
(systems without VGAcon), it would know not to try and print anything
until something reattaches to it.

-- 
Jon Smirl
jonsmirl@gmail.com
