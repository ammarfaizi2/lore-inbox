Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031307AbWKUTC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031307AbWKUTC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031314AbWKUTC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:02:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:48261 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1031307AbWKUTC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:02:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MiMT0j2acyL1dRJ5xPSoFWlFU1vsZlXZC5SqWnCXruHudnNUfZQvocYXdbSBhZiimsfT68hH0DiIQB0d/Y8TvuT7N8WewpLY8JzgfoGuenp8tJXcR0Mi1N/Dp/wPwW6daYDaqpXJrQ8bbCxn4iZZ4wQJ9YnR44a29h8vT8W14Rc=
Message-ID: <d120d5000611211102w79d6729cx75f04c731ccc943c@mail.gmail.com>
Date: Tue, 21 Nov 2006 14:02:26 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Paul Sokolovsky" <pmiscml@gmail.com>
Subject: Re: Re[2]: Where did find_bus() go in 2.6.18?
Cc: "Greg KH" <gregkh@suse.de>, "Arjan van de Ven" <arjan@infradead.org>,
       "Jiri Slaby" <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       "Adrian Bunk" <bunk@stusta.de>, kernel-discuss@handhelds.org
In-Reply-To: <1148526308.20061120161322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1154868495.20061120003437@gmail.com> <4560ECAF.1030901@gmail.com>
	 <20061120001212.GA28427@suse.de> <1148526308.20061120161322@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/06, Paul Sokolovsky <pmiscml@gmail.com> wrote:
>
> [Uninteresting specific case]
>
>  Ok, so the situation is following: we have a kind of multi-layered
> driver here. Lowest level is a w1_slave bus driver, talking to a
> specific chip and providing low-level API for accessing data in terms
> of this chip (or chip class) notions. Above it, we have higher-level
> driver which interprets data from the low-level one, converting it to
> a standard device-independent form, plus possibly does some other
> minor things, like providing feedback indication on these data.
> (Forgot to say that this is battery driver.)
>
>  So, just in case if some reader of this has quick suggestion of
> merging these drivers into one, thanks, but they do different things,
> and we want to keep them nicely decoupled. But now issue of how these
> drivers talk between themselves raises, and that's exactly the grief
> point.
>

My suggestion would be do define a class for your device independent
data and have low-level driver create a class device (or just a device
if Greg has his way with driver core) and change your high-level
driver to become a class interface.

And then you won't have to rescan w1 bus every 5 seconds for that battery...

-- 
Dmitry
