Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbVINMx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbVINMx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 08:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVINMxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 08:53:55 -0400
Received: from quark.didntduck.org ([69.55.226.66]:31172 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S965062AbVINMxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 08:53:55 -0400
Message-ID: <43281D3A.9080407@didntduck.org>
Date: Wed, 14 Sep 2005 08:53:14 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernhard Ager <ager@in.tum.de>
CC: vojtech@suse.cz, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Joystick on amd64 for 32bit programs
References: <20050914100244.GC9770@in.tum.de>
In-Reply-To: <20050914100244.GC9770@in.tum.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Ager wrote:
> Hi,
> 
> the patch below makes the joystick on amd64 work for 32bit
> applications. It was successfully tested by myself with X-Plane [1],
> SilentWings [2], Quake 3 [3] and quite some other applications. 
> 
> How it works: as the parameters in 32bit userspace ioctl are
> compatible with the 64bit kernel, it is sufficient to declare them
> compatible in ia32_ioctl.c. The JSIOCGNAME ioctl causes a problem as
> it encodes the length of the return buffer into the ioctl number. This
> is solved by mapping all of the JSIOCGNAME ioctls to JSIOCGNAME(0).
> 
> Patch is below and works for vanilla kernels at least up to
> 2.6.13.

This patch uses the obsolete method of defining compat ioctls.  The 
joydev ioctls are already fixed (using ->compat_ioctl) in more recent 
kernels.

--
				Brian Gerst
