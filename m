Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263173AbREWRVB>; Wed, 23 May 2001 13:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263174AbREWRUm>; Wed, 23 May 2001 13:20:42 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:30216 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S263173AbREWRUe>;
	Wed, 23 May 2001 13:20:34 -0400
Date: Wed, 23 May 2001 13:23:46 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: What's up with GT96100 in the MIPS config file?
Message-ID: <20010523132346.A16993@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Near line 55 of drivers/net/Config.in there is code that reads like this:

   if [ "$CONFIG_MIPS_GT96100" = "y" ]; then
      bool '  MIPS GT96100 Ethernet support' CONFIG_MIPS_GT96100ETH
   fi

All very well except that CONFIG_MIPS_GT96100 is never set (or even
used) anywhere else.  My cross-reference generator shows this:

snark:~/src/linux$ scripts/kxref.py | grep GT96    
CONFIG_MIPS_GT96100: drivers/net/Config.in
CONFIG_MIPS_GT96100ETH: drivers/net/Makefile drivers/net/Config.in drivers/net/gt96100eth.c

The simplest guess is that the guard part is just wrong.  Can anybody shed
any light on this?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The saddest life is that of a political aspirant under democracy. His
failure is ignominious and his success is disgraceful.
        -- H.L. Mencken
