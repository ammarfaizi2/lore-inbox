Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318395AbSGRXoj>; Thu, 18 Jul 2002 19:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318396AbSGRXoi>; Thu, 18 Jul 2002 19:44:38 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:29708 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318395AbSGRXoi>;
	Thu, 18 Jul 2002 19:44:38 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207182347.g6INlcl47289@saturn.cs.uml.edu>
Subject: Re: close return value
To: patl@curl.com (Patrick J. LoPresti)
Date: Thu, 18 Jul 2002 19:47:38 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <s5gadop9jxq.fsf@egghead.curl.com> from "Patrick J. LoPresti" at Jul 18, 2002 10:42:25 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick J. LoPrest writes:

> Failures happen.  They can happen on write(), they can happen on
> close(), and they can happen on any system call for which the API
> allows it.  There is no difference!  Your application either deals
> with them and is correct or fails to deal with them and is broken.
> 
> If the API allows an error return, you *must* check for it, period.
> This includes "impossible" errors.  You may think it is impossible for
> gettimeofday() to return an error in some case, but if it ever did,
> you should darn well want to know about it right away.
> 
> If you are that convinced that close() can not return an error in your
> particular application (e.g., because you "know" you are using a local
> disk, or the file descriptor is read-only), then treat such errors
> like assertion failures.  Because that is what they are.
> 
> Checking system calls for errors, always, is fundamental to writing
> reliable code.  Failing to check them is shoddy and amateurish
> programming.  It is amazing that so many people would argue this
> point.  Then again, maybe not, given how bad most software is...

You check printf() and fprintf() then? Like this?

///////////////////////////////////////////
void err_print(int err){
  const char *msg;
  int rc;

  msg = strerror(err);
  if(!msg) err_print(errno);

  do{
    rc = fprintf(stderr,"Problem: %s\n",msg);
  }while(rc<0 && errno==EINTR);
  if(rc<0) err_print(errno);
}
///////////////////////////////////////////

Get off your high horse.
