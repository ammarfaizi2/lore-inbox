Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbTCAXlT>; Sat, 1 Mar 2003 18:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269077AbTCAXlT>; Sat, 1 Mar 2003 18:41:19 -0500
Received: from mail.zmailer.org ([62.240.94.4]:27843 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267357AbTCAXlS>;
	Sat, 1 Mar 2003 18:41:18 -0500
Date: Sun, 2 Mar 2003 01:51:39 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Stephen Corey <s_corey@netzero.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel tuning for high latency satellite link??
Message-ID: <20030301235139.GD1073@mea-ext.zmailer.org>
References: <000001c2e00b$71bb7d50$0301a8c0@corey> <132088132.1046604929@[192.168.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132088132.1046604929@[192.168.0.1]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 11:35:29AM +1300, Andrew McGregor wrote:
> On Saturday, 1 March 2003 10:58 a.m. -0500 Stephen Corey
>   <s_corey@netzero.com> wrote:
> >Do I need to tune the linux kernel (2.4.18-3) for high latency
> >connections? I'm installing a linux box on a satellite link (~800 ms
> >roundtrip latency). Will the kernel *automatically* change anything
> >based on latency, to hurt my throughput performance??
> 
> It should do OK by default, but you might want to read RFC 3150 for some 
> ideas for things to do to help.

PILC doesn't really help in all cases.
E.g. hight bandwidth * long delay does produce its own problems.

To achieve maximum performance from a tcp-stream,  you need to have
the amount of unacknowledge in-flight data matching that "delay-band-
width product".  In Linux, the   setsockopt() SO_SNDBUF parameter
must be TWICE that value.    Oh, and at the receiving side the
SO_RCVBUF parameter must have matching value.

System-wide default values are at   /proc/sys/net/core/*mem_*
See explanations at  "man 7 socket".  (In cases where application
does NOT set their own values, *mem_default  are used,  and in
all cases, *mem_max  clamp the upper limit.)


If you are pushing some half-duplex application traffic over this
kind of link where latency is longish, no amount of kernel tuning
can help you.   Example of such application protocol is SMTP.
There is  PIPELINING  mode,  which helps by turning SMTP into a semi-
duplex with full syncronization stops only at DATA or BDAT verbs.
However not all MTAs claiming PIPELINING capability in their EHLO-
responses implement it themselves in SMTP client code.
Most notable of those is qmail.


> Andrew

/Matti Aarnio
