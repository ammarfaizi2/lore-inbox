Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318145AbSG3AGw>; Mon, 29 Jul 2002 20:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318146AbSG3AGw>; Mon, 29 Jul 2002 20:06:52 -0400
Received: from jalon.able.es ([212.97.163.2]:3058 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318145AbSG3AGw>;
	Mon, 29 Jul 2002 20:06:52 -0400
Date: Tue, 30 Jul 2002 02:09:12 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Theurer <habanero@us.ibm.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
Message-ID: <20020730000912.GA6406@714-cm.cps.unizar.es>
References: <Pine.LNX.4.44L.0207292051040.3086-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44L.0207292051040.3086-100000@imladris.surriel.com>; from riel@conectiva.com.br on mar, jul 30, 2002 at 01:51:51 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20020730 Rik van Riel wrote:
> On Tue, 30 Jul 2002, Andrea Arcangeli wrote:
> 
> > and the new one had a bug too :). Please merge the fix I posted to l-k
> > too thanks.
> 
> Judging from the patch the code seems incredibly subtle and
> I'd be amazed if it doesn't break again every few weeks...
> 

How about this version (gcc-3.2 generates the same amount of assembler):

int find(int this_cpu)
{
    int i;

    for (   i = (this_cpu+1)%smp_num_cpus;
            i != this_cpu;
            i = (i+1)%smp_num_cpus  )
    {
        int physical = cpu_logical_map(i);
        int sibling = cpu_sibling_map[physical];

        if (idle_cpu(physical) && idle_cpu(sibling))
            return physical;
    }
    return -1;
}

