Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312511AbSDEMYl>; Fri, 5 Apr 2002 07:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312524AbSDEMYX>; Fri, 5 Apr 2002 07:24:23 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:45199 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S312505AbSDEMYB>; Fri, 5 Apr 2002 07:24:01 -0500
Date: Fri, 5 Apr 2002 14:23:51 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: socket write(2) after remote shutdown(2) problem ?
Message-ID: <20020405122351.GH16595@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020405105509.GE16595@come.alcove-fr> <20020405.030251.28451401.davem@redhat.com> <20020405120054.GF16595@come.alcove-fr> <20020405.040451.127871174.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 04:04:51AM -0800, David S. Miller wrote:

>    From: Stelian Pop <stelian.pop@fr.alcove.com>
>    Date: Fri, 5 Apr 2002 14:00:55 +0200
> 
>    As you can see, read() doesn't return any error, just 0 to 
>    indicate end-of-file (seems correct interpretation of remote
>    shutdown here), but it doesn't report any error from the 
>    precedent write... Bug ?
> 
> Race, wait a bit, the reset will arrive.

30 seconds later the read still returns 0...

> Look, your app is buggy, PERIOD.  Once you start to write to a closed
> socket, sorry the phase of the moon decides what happens to you.  Most
> of the time you'll be lucky and see an error.

The socket is not closed on the client side. I expect the kernel to
signal me an error (reset of read/write return code, whatever) if
the connection is closed by the _server_ (with close OR shutdown).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
