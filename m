Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWCRUXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWCRUXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWCRUXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:23:55 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:125 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750931AbWCRUXy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:23:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fNndYECbSRDPLJOfr+r6Rfxv30RFjj5yvUYeNQGNU9HSN730H8yWBV2rGXD2F+bE+syohpsz8CxklAElQpfHkEow6HLijOXclsU/h/2AVsJopO30r6Cf/sNoYuuNyEvwoMzONnsWbvqLws1nQdMJXy7y71u9tEXIxl42eV1GSm4=
Message-ID: <9a8748490603181223i32391d96nf794e93aa734f785@mail.gmail.com>
Date: Sat, 18 Mar 2006 21:23:52 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Cc: "Thomas Gleixner" <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, trini@kernel.crashing.org
In-Reply-To: <20060318120728.63cbad54.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060318142827.419018000@localhost.localdomain>
	 <20060318142830.607556000@localhost.localdomain>
	 <20060318120728.63cbad54.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/06, Andrew Morton <akpm@osdl.org> wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > According to the specification the timeval must be validated and
> > an errorcode -EINVAL returned in case the timeval is not in canonical
> > form. Before the hrtimer merge this was silently ignored by the
> > timeval to jiffies conversion. The validation is done inside
> > do_setitimer so all callers are catched.
> >
[...]
>
> From my reading, 2.4's sys_setitimer() will normalise the incoming timeval
> rather than rejecting it.  And I think 2.6.13 did that too.
>
> It would be bad of us to change this behaviour, even if that's what the
> spec says we should do - because we can break existing applications.
>
> So I think we're stuck with it - we should normalise and then accept such
> timevals.  And we should have a big comment explaining how we differ from
> the spec, and why.
>

Wouldn't this only break existing applications that do incorrect
things (passing invalid values) ?
If that's the case I'd say breaking them is OK and we should change to
follow the spec.

I don't like potential userspace breakage any more than the next guy,
but if the breakage only affects buggy applications then I think it's
more acceptable.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
