Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284836AbRLKClO>; Mon, 10 Dec 2001 21:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284837AbRLKClF>; Mon, 10 Dec 2001 21:41:05 -0500
Received: from ns.ithnet.com ([217.64.64.10]:1298 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S284836AbRLKCkz>;
	Mon, 10 Dec 2001 21:40:55 -0500
Message-Id: <200112110240.DAA08323@webserver.ithnet.com>
Date: Tue, 11 Dec 2001 03:40:45 +0100
Subject: Re: 2.4.17-pre7: Oops with Tulip
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Burton W <bwindle@fint.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.43.0112101918080.204-100000@morpheus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,                                                              
                                                                      
this is a story regarding tulip-driver in a two separate cards-setup  
where the driver thinks it is a multiple board setup, but the         
eeprom-values do not back this theory. This seems the reason, why     
last_ee_data turns out as NULL and its members get references later   
on, which obviously breaks.                                           
I fixed this with the patch on the very end of this, but am not 100%  
sure if this is valid and does not break other setups.                
Can you comment/verify/submit the bugfix-patch to marcelo and L for   
inclusion?                                                            
                                                                      
Thanks,                                                               
Stephan                                                               
                                                                      
                                                                      
                                                                      
> It works! :)                                                        
>                                                                     
> Here is 2.4.17-pre7 with your tulip patch when I modprobe the tulip 
> driver:                                                             
>                                                                     
> Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)                
> PCI: Found IRQ 9 for device 00:09.0                                 
> PCI: Setting latency timer of device 00:09.0 to 64                  
> tulip0:  EEPROM default media type Autosense.                       
> tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
> block.                                                              
> tulip0:  Index #1 - Media 10baseT (#0) described by a 21140 non-MII 
(0)                                                                   
> block.                                                              
> tulip0:  Index #2 - Media 100baseTx (#3) described by a 21140       
non-MII (0)                                                           
> block.                                                              
> tulip0:  Index #3 - Media 10baseT-FDX (#4) described by a 21140     
non-MII                                                               
> (0) block.                                                          
> tulip0:  Index #4 - Media 100baseTx-FDX (#5) described by a 21140   
non-MII                                                               
> (0) block.                                                          
> tulip0:  MII transceiver #1 config 3100 status 7809 advertising     
05e1.                                                                 
> eth1: Davicom DM9102/DM9102A rev 32 at 0xb800, 00:E0:3F:04:58:60,   
IRQ 9.                                                                
> PCI: Enabling device 00:0b.0 (0080 -> 0083)                         
> PCI: Assigned IRQ 9 for device 00:0b.0                              
> PCI: Setting latency timer of device 00:0b.0 to 64                  
> tulip1:  Controller 1 of multiport board.                           
> tulip1:  EEPROM default media type Autosense.                       
> tulip1:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
> block.                                                              
> tulip1:  Index #1 - Media 10baseT (#0) described by a <unknown>     
(128)                                                                 
> block.                                                              
> tulip1:  Index #2 - Media 10baseT (#0) described by a 21140 non-MII 
(0)                                                                   
> block.                                                              
> tulip1:  Index #3 - Media 10base2 (#1) described by a 21140 non-MII 
(0)                                                                   
> block.                                                              
> tulip1:  Index #4 - Media 10baseT-FDX (#4) described by a 21140     
non-MII                                                               
> (0) block.                                                          
> tulip1:  Index #5 - Media 100baseTx-FDX (#5) described by a 21140   
non-MII                                                               
> (0) block.                                                          
> tulip1: ***WARNING***: No MII transceiver found!                    
> eth2: Macronix 98713 PMAC rev 0 at 0xff00, EEPROM not present,      
> 00:E0:3F:04:58:61, IRQ 9.                                           
>                                                                     
> In other words, it works :)                                         
>                                                                     
> If I swap the cards in their PCI slots now, modprobing tulip gives  
this:                                                                 
> Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)                
> PCI: Found IRQ 9 for device 00:09.0                                 
> PCI: Setting latency timer of device 00:09.0 to 64                  
> tulip0:  EEPROM default media type 100baseTx.                       
> tulip0:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII 
(0)                                                                   
> block.                                                              
> tulip0:  Index #1 - Media 100baseTx (#3) described by a 21140       
non-MII (0)                                                           
> block.                                                              
> tulip0:  Index #2 - Media 10baseT-FDX (#4) described by a 21140     
non-MII                                                               
> (0) block.                                                          
> tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140   
non-MII                                                               
> (0) block.                                                          
> eth1: Macronix 98713 PMAC rev 0 at 0xb800, 00:40:33:9A:B3:20, IRQ 9.
> PCI: Found IRQ 9 for device 00:0b.0                                 
> PCI: Setting latency timer of device 00:0b.0 to 64                  
> tulip1:  EEPROM default media type Autosense.                       
> tulip1:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
> block.                                                              
> tulip1:  Index #1 - Media 10baseT (#0) described by a 21140 non-MII 
(0)                                                                   
> block.                                                              
> tulip1:  Index #2 - Media 100baseTx (#3) described by a 21140       
non-MII (0)                                                           
> block.                                                              
> tulip1:  Index #3 - Media 10baseT-FDX (#4) described by a 21140     
non-MII                                                               
> (0) block.                                                          
> tulip1:  Index #4 - Media 100baseTx-FDX (#5) described by a 21140   
non-MII                                                               
> (0) block.                                                          
> tulip1:  MII transceiver #1 config 3100 status 7809 advertising     
05e1.                                                                 
> eth2: Davicom DM9102/DM9102A rev 32 at 0xb000, 00:E0:3F:04:58:60,   
IRQ 9.                                                                
>                                                                     
> Can we get this to go into 2.4.17-rc1?                              
>                                                                     
> --                                                                  
> Burton Windle                           burton@fint.org             
> Linux: the "grim reaper of innocent orphaned children."             
>           from /usr/src/linux-2.4.0/init/main.c:655                 
>                                                                     
>                                                                     
> On Mon, 10 Dec 2001, Stephan von Krawczynski wrote:                 
>                                                                     
> > On Mon, 10 Dec 2001 01:08:28 -0500 (EST)                          
> > Burton W <bwindle@fint.org> wrote:                                
> >                                                                   
> > Just to test a theory: please try attached patch.                 
> >                                                                   
> > Regards,                                                          
> > Stephan                                                           
> >                                                                   
> > --- eeprom.c-orig       Mon Dec 10 14:24:35 2001                  
> > +++ eeprom.c    Mon Dec 10 14:25:41 2001                          
> > @@ -130,9 +130,9 @@                                               
> >         }                                                         
> >                                                                   
> >         controller_index = 0;                                     
> > -       if (ee_data[19] > 1) {          /* Multiport board. */    
> > -               last_ee_data = ee_data;                           
> > -       }                                                         
> > +                                                                 
> > +       last_ee_data = ee_data;                                   
> > +                                                                 
> >  subsequent_board:                                                
> >                                                                   
> >         if (ee_data[27] == 0) {         /* No valid media table.  
*/                                                                    
> > -                                                                 
> > To unsubscribe from this list: send the line "unsubscribe         
linux-kernel" in                                                      
> > the body of a message to majordomo@vger.kernel.org                
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/                  
> >                                                                   
> >                                                                   
>                                                                     
>                                                                     
>                                                                     
>                                                                     
