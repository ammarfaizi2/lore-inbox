Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318407AbSIBTpL>; Mon, 2 Sep 2002 15:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318426AbSIBTpK>; Mon, 2 Sep 2002 15:45:10 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:44817 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S318407AbSIBTpK>; Mon, 2 Sep 2002 15:45:10 -0400
Date: Mon, 02 Sep 2002 13:48:27 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: CAMTP guest <camtp.guest@uni-mb.si>, Doug Ledford <dledford@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <1305380000.1030996107@aslan.scsiguy.com>
In-Reply-To: <15731.47392.215325.798396@proizd.camtp.uni-mb.si>
References: <15731.22574.493121.798425@proizd.camtp.uni-mb.si>
 <1231170000.1030981811@aslan.scsiguy.com> <20020902140509.A10976@redhat.com>
 <15731.47392.215325.798396@proizd.camtp.uni-mb.si>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doug Ledford writes:
> 
>  > took the device off line.  So, in short, the mid layer isn't waiting
> long   > enough, or when it gets sense indicated not ready it needs to
> implement a   > waiting queue with a timeout to try rekicking things a
> few times and don't   > actually mark the device off line until a longer
> period of time has   > elasped without the device coming back.
> 
> There is a kernel config CONFIG_AIC7XXX_RESET_DELAY_MS (default 15s).
> Would increasing it help?

This currently only effects the initial bus reset delay.  If the driver
holds off commands after subsequent bus resets, it can cause undeserved
timeouts on the commands it has intentionally deferred.  The mid-layer has
a 5 second delay after bus resets, but I haven't verified that this is
honored correctly during error recovery.

--
Justin
