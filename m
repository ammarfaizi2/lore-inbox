Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVF2UHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVF2UHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVF2UHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:07:37 -0400
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:24701 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262539AbVF2UHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:07:33 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, hetfield666@gmail.com
Subject: Re: psmouse sysfs problems
Date: Wed, 29 Jun 2005 15:07:27 -0500
User-Agent: KMail/1.8.1
References: <1120057685.31934.36.camel@blight.blightgroup>
In-Reply-To: <1120057685.31934.36.camel@blight.blightgroup>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506291507.28015.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 June 2005 10:08, Hetfield wrote:
> pwd
> /sys/bus/serio/devices/serio0
> root@blight serio0 # cat protocol
> ImPS/2
> root@blight serio0 # cat resetafter
> 0
> root@blight serio0 # echo 5 > res
> resetafter  resolution
> root@blight serio0 # echo 5 > resetafter
> root@blight serio0 # cat resetafter
> 0
> root@blight serio0 #            
> 
> and sending 0, 1, 2 to protocol changed nothing.
> same for resolution.
> i needed that feature to switch from synaptics to imps protocol and
> back.
> 
> i'm using 2.6.12-git10.
> 
> what should i do?
>

Hi,

try this:

    echo -n "imps" > /sys/bus/serio/devices/serioX/protocol
    echo -n "auto" > /sys/bus/serio/devices/serioX/protocol

psmouse (and serio core in general) does not like exta characters (like
newline) in requests and discards such requests.

-- 
Dmitry
