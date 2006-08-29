Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWH2O7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWH2O7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWH2O7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:59:21 -0400
Received: from smtp104.plus.mail.re2.yahoo.com ([206.190.53.29]:1894 "HELO
	smtp104.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932104AbWH2O7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:59:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
  b=bpKxg7G4RL89AgadBqyqZBbh1Qu4d+DcNaANQev5tWJPCwtZAopLLU56NS3KagijWrCbPcdmgY82PQKhfvRaVgLvz8SoQ4BIgtP1jbq5WG4mP/E2jKnsbtVMdoEZoqupR/rtsY6ONMvw//oPPcTthgwKR0fg1T7fm2rE64Kw6SI=  ;
Date: Tue, 29 Aug 2006 16:59:17 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Message-ID: <20060829145917.GA13972@gollum.tnic>
Reply-To: petkov@math.uni-muenster.de
References: <20060820013121.GA18401@fieldses.org> <200608291316.22327.ak@suse.de> <20060829130050.GA12773@gollum.tnic> <200608291636.56673.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608291636.56673.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 04:36:56PM +0200, Andi Kleen wrote:
> On Tuesday 29 August 2006 15:00, Borislav Petkov wrote:
> > On Tue, Aug 29, 2006 at 01:16:22PM +0200, Andi Kleen wrote:
> > > 
> > > > 
> > > > Without a hex dump of stack contents there's very little I can do.
> > > 
> > > Borislav, if you can reproduce the crash please boot with kstack=2048 and send output
> > > of that.
> > Yeah, 
> >     that's a no-go, same output:
> 
> Can you please try it with this debug patch?
> 
> -Andi
> 
> Index: linux/arch/x86_64/kernel/traps.c
Sorry,
    but this patches x86_64 arch and mine is i386. I could change the
    kstack_depth_to_print from 24 to 2048 in
    linux/arch/i386/kernel/traps.c by hand instead but I don't have
    a _show_stack function there, do I? Or maybe that is not at all necessary to see a
    "proper" stack dump?

> ===================================================================
> --- linux.orig/arch/x86_64/kernel/traps.c
> +++ linux/arch/x86_64/kernel/traps.c
> @@ -106,7 +106,7 @@ static inline void preempt_conditional_c
>  	preempt_enable_no_resched();
>  }
>  
> -static int kstack_depth_to_print = 12;
> +static int kstack_depth_to_print = 2048;
>  #ifdef CONFIG_STACK_UNWIND
>  static int call_trace = 1;
>  #else
> @@ -418,7 +418,7 @@ void show_stack(struct task_struct *tsk,
>  void dump_stack(void)
>  {
>  	unsigned long dummy;
> -	show_trace(NULL, NULL, &dummy);
> +	_show_stack(NULL, NULL, &dummy);
>  }
>  
>  EXPORT_SYMBOL(dump_stack);

Regards,
    Boris.

	

	
		
___________________________________________________________ 
Der frühe Vogel fängt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de
