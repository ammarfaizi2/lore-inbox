Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293725AbSCSFZX>; Tue, 19 Mar 2002 00:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293737AbSCSFZE>; Tue, 19 Mar 2002 00:25:04 -0500
Received: from codepoet.org ([166.70.14.212]:15561 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S293725AbSCSFYz>;
	Tue, 19 Mar 2002 00:24:55 -0500
Date: Mon, 18 Mar 2002 22:24:57 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, Dieter.Nuetzel@hamburg.de,
        linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
Message-ID: <20020319052457.GA25461@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	"David S. Miller" <davem@redhat.com>, Dieter.Nuetzel@hamburg.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020318.162031.98995076.davem@redhat.com> <Pine.LNX.4.33.0203181805460.10711-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 18, 2002 at 06:08:17PM -0800, Linus Torvalds wrote:
> 
> On Mon, 18 Mar 2002, David S. Miller wrote:
> >    
> >    Or maybe the program is just flawed, and the interesting 1/8 pattern comes 
> >    from something else altogether.
> > 
> > I think the weird Athlon behavior has to do with the fact that
> > you've made your little test program as much of a cache tester
> > as a TLB tester :-)
> 
> Oh, I was assuming that malloc(BIG) would do a mmap() of MAP_ANONYMOUS, 

Perhaps adding an explicit 

    void *malloc(size_t size)
    {
	void *result = mmap((void *) 0, size + sizeof(size_t), PROT_READ | PROT_WRITE,
		MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
	if (result == MAP_FAILED)
	    exit(EXIT_FAILURE);
	* (size_t *) result = size;
	return(result + sizeof(size_t));
    }

would ensure libc isn't trying to do something sneaky,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
