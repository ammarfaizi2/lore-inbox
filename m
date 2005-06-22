Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVFVQwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVFVQwH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVFVQwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:52:06 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:25259 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261619AbVFVQsB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:48:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tqra4KyNbdHav8rEgGfLbDkDV2Lg60c3yocrEp9Pje1tQyVmG92LRdRLda0fWdY3ZhPN/30YYxTCY887Uwtc3HIfjOghLlbk0wJQuNBQyNGjT6qtzscjr64DOkP1qFPPYqlKzeBsUcbaJV+rn6sezXhq0P2+VyBQACs0Z8lgfZY=
Message-ID: <a4e6962a05062209486115ec@mail.gmail.com>
Date: Wed, 22 Jun 2005 11:48:00 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Cc: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
In-Reply-To: <E1Dl85I-0007nR-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
	 <20050622004902.796fa977.akpm@osdl.org>
	 <E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu>
	 <20050622021251.5137179f.akpm@osdl.org>
	 <E1Dl1Oz-0007Dq-00@dorka.pomaz.szeredi.hu>
	 <20050622024423.66d773f3.akpm@osdl.org>
	 <E1Dl20U-0007Ic-00@dorka.pomaz.szeredi.hu>
	 <a4e6962a0506220523791a31da@mail.gmail.com>
	 <E1Dl85I-0007nR-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > I'm confused why everything has to be remounted nosuid.  I understand
> > enforcing synthetics to be mounted nosuid, but not the rest of the
> > file systems.
> 
> It's related to the problem of a suid program accessing synthetic
> filesystem, and filesystem doing something bad to suid program (make
> it hang, supply bogus data ...).  This can be solved by "squashing"
> suid for the whole namespace (basically the Plan 9 solution).
> Unfortunately this is not really practical in Linux/Unix.
> 

Just to make sure I understand you - if I don't squash suid for the
entire name space, a user could mount a malicious synthetic (even with
NOSUID) and then launch an SUID app from an inherited mount which
would then traverse to the malicious synthetic.

That's a nasty case I hadn't considered before -- however, what's the
potential damage there?  The user could hold up progress of the SUID
app that they launched, but that wouldn't necessarily impede system
progress since system-critical suid apps wouldn't be typically
launched by a user.  I suppose there is the possibility that if
multiple instances of such an SUID app share a global lock you could
get into trouble -- do we have any concrete example apps that would
exhibit this kind of behavior?

Are there other vunerabilities that I'm missing?

      -eric
