Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWC1GKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWC1GKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 01:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWC1GKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 01:10:52 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:28297 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751080AbWC1GKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 01:10:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Shaun Jackman" <sjackman@gmail.com>
Subject: Re: [PATCH] elo: Support non-pressure-sensitive ELO touchscreens
Date: Tue, 28 Mar 2006 01:10:46 -0500
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <7f45d9390602241045p45aec8auaf881a4dab00c17a@mail.gmail.com> <d120d5000603270828w4aef947cy7202da6076dd1268@mail.gmail.com> <7f45d9390603271515m17a5ee1due5bc3f9f2285ca62@mail.gmail.com>
In-Reply-To: <7f45d9390603271515m17a5ee1due5bc3f9f2285ca62@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603280110.47199.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 March 2006 18:15, Shaun Jackman wrote:
> On 3/27/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > We should not only omit reporting pressure if toucscreen does not
> > support it but also not set ABS_PRESSURE bit in input device.
> 
> Can I simply call input_set_abs_params and serio_set_drvdata again to
> change these bits on the fly based on the 'T' packets? What value
> should be the default before a 'T' packet has been received? I'd
> suggest no pressure.
>

No, we should not change basic input device's capabilities "on-fly" -
userspace should be able to rely on what was reported to it in the first
place. From looking over the documentation (thank you for the link)
it looks like you would need to issue 'i' command to query controller
type and whether the controller supports Z-axis in elo_connect(). 

> > What is the reason for postponing checking for 'T' until full packet
> > is assembled? Did you actually see packets with valid checksum but
> > without 'T'?
> 
> I believe the 'T' packet is the only packet that the touchscreen sends
> unrequested. However, the touch screen can send a number of other
> packets as well. The protocol documentation is available from Elo:
> 
> 	http://elotouch.com/files/manuals/smartset.zip
> 

OK, I see.

-- 
Dmitry
