Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131476AbRASXcN>; Fri, 19 Jan 2001 18:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136982AbRASXcD>; Fri, 19 Jan 2001 18:32:03 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:21774
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131476AbRASXbp>; Fri, 19 Jan 2001 18:31:45 -0500
Date: Sat, 20 Jan 2001 12:31:39 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Michael Lindner <mikel@att.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data available
Message-ID: <20010120123139.B549@metastasis.f00f.org>
In-Reply-To: <3A68A7D0.FF534B97@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A68A7D0.FF534B97@att.net>; from mikel@att.net on Fri, Jan 19, 2001 at 03:47:12PM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    	main()
    	{
    	        for (int i = 0; i < 1000; i++) {
    			struct timeval to;
    			to.tv_sec = 0;
    			to.tv_usec = 1000;
    			select(0, 0, 0, 0, &to);
    		}
    		return 0;
    	}

ia32 with HZ=100 means sleep will sleep for 10ms each time, no less.
The time passed to slect is a _minimum_ the kernel make no guarantee
it will be less, but assures it will be more (10ms is the default
timer interval for the intel platform, others (e.g. alpha) differ)

run your conde with strace -t to see what i mean



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
