Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbUK3Kba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUK3Kba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 05:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbUK3Kba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 05:31:30 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:15625 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262035AbUK3Kac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 05:30:32 -0500
Message-ID: <48590.195.245.190.94.1101810584.squirrel@195.245.190.94>
In-Reply-To: <20041129152344.GA9938@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93>
    <20041129111634.GB10123@elte.hu>
    <41358.195.245.190.93.1101734020.squirrel@195.245.190.93>
    <20041129143316.GA3746@elte.hu> <20041129152344.GA9938@elte.hu>
Date: Tue, 30 Nov 2004 10:29:44 -0000 (WET)
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041130102944_19040"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 30 Nov 2004 10:30:23.0503 (UTC) FILETIME=[997B09F0:01C4D6C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041130102944_19040
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Ingo Molnar wrote:
>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
>> but please try to the -31-10 kernel that i've just uploaded, it has a
>> number of tracer enhancements:
>
> make that -31-13 (or later). Earlier kernels had a bug in where the
> process name tracking only worked for the first latency trace saved,
> subsequent traces showed 'unknown' for the process name. In -13 i've
> also added a printk that shows the latest user latency in a one-line
> printk - just like the built-in latency tracing modes do:
>
>  (gettimeofday/3671/CPU#0): new 3068 us user-latency.
>  (gettimeofday/3784/CPU#0): new 1008627 us user-latency.
>
> (this should also make it easier for helper scripts to save the traces,
> whenever they happen.)
>

OK.

I did my homework and managed to grab some latency traces for you to take
a look and see if it's alright. Please.

On attach you may find the files:

    xruntrace1.1.tar.gz
        - scripts used to arm and capture the latency traces;

    jack-0.99.14.0xruntrace-alsa.patch.gz
        - the actual patch applied to jack for trace auto-triggering;

    config-2.6.10-rc2-mm3-RT-V0.7.31-13.gz
        - the running kernel configuration, as taken from /proc/config.gz

    xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-13-*.trc.gz
        - the captured traces, as dumped with xruntrace1_watch.sh script.

    jack_test3.2.tar.gz
        - updated my jack_test3 benchmarking suite.


The traces were captured, while running a usual KDE desktop session (from
qjackctl) on my P4@2.53Ghz laptop (Mandrake 10.1):

    jackd -R -P60 -dalsa -dhw:0 -r44100 -p64 -n2 -S -P

Each trace shows only the first XRUN occurrence on a distinct jackd
session. Every other trace were triggered and captured after restarting
jackd.

Must say that XRUNs are rare but do occurr. Using the same jackd command
line, my jack_test3 suite is showing these figures by now:

    *********** CONSOLIDATED RESULTS ************
    Total seconds ran . . . . . . :  7200
    Number of clients . . . . . . :    16
    Ports per client  . . . . . . :     4
    *********************************************
    Summary Result Count  . . . . :     2 /     2
    *********************************************
    Timeout Rate  . . . . . . . . :(    0.0)/hour
    XRUN Rate . . . . . . . . . . :    13.8 /hour
    Delay Rate (>spare time)  . . :    13.8 /hour
    Delay Rate (>1000 usecs)  . . :     7.0 /hour
    Delay Maximum . . . . . . . . :  1022   usecs
    Cycle Maximum . . . . . . . . :  1048   usecs
    Average DSP Load. . . . . . . :    62.2 %
    Average CPU System Load . . . :    20.6 %
    Average CPU User Load . . . . :    48.5 %
    Average CPU Nice Load . . . . :     0.0 %
    Average CPU I/O Wait Load . . :     0.0 %
    Average CPU IRQ Load  . . . . :     0.0 %
    Average CPU Soft-IRQ Load . . :     0.0 %
    Average Interrupt Rate  . . . :  1689.2 /sec
    Average Context-Switch Rate . : 19778.2 /sec
    *********************************************

The IRQ process/threading priority status has been fixed as shown below:

  PID CLS RTPRIO  NI PRI %CPU STAT COMMAND
    2 FF      90   - 130  0.0 S    IRQ 0
  728 FF      80   - 120  0.0 S<   IRQ 8
 2943 FF      70   - 110  0.0 S<   IRQ 5
 1500 FF      60   - 100  0.0 S<   IRQ 10
  841 FF      50   -  90  0.0 S<   IRQ 1
  736 FF      49   -  89  0.0 S<   IRQ 12
   20 FF      48   -  88  0.0 S<   IRQ 9
  814 FF      45   -  85  0.0 S<   IRQ 6
  821 FF      44   -  84  0.0 S<   IRQ 14
  823 FF      43   -  83  0.0 S<   IRQ 15
 2227 FF      40   -  80  0.0 S<   IRQ 11

# cat /proc/interrupts

           CPU0
  0:    6435186          XT-PIC  timer  0/35186
  1:       1164          XT-PIC  i8042  1/1164
  2:          0          XT-PIC  cascade  0/0
  5:         73          XT-PIC  ALI 5451  0/72
  8:          1          XT-PIC  rtc  0/1
  9:      20602          XT-PIC  acpi  0/20602
 10:          0          XT-PIC  ohci_hcd, ohci_hcd  0/0
 11:          5          XT-PIC  yenta  5/5
 12:      64317          XT-PIC  i8042  0/64317
 14:      11772          XT-PIC  ide0  0/11772
 15:         19          XT-PIC  ide1  0/19
NMI:          0
LOC:          0
ERR:          0
MIS:          0


Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20041130102944_19040
Content-Type: application/x-gzip-compressed; name="xruntrace1.1.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xruntrace1.1.tar.gz"

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
------=_20041130102944_19040
Content-Type: application/x-gzip-compressed;
      name="jack-0.99.14.0xruntrace-alsa.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename="jack-0.99.14.0xruntrace-alsa.patch.gz"

H4sICIw1q0EAA2phY2stMC45OS4xNC4weHJ1bnRyYWNlLWFsc2EucGF0Y2gAhVJta9swEP5s/4oj
ZSGJX2I5y8tSFjpYv422hA02KAjPkoM3RzaSnDas+++9s9I2zWDVB3G6e+7Rcy+iLAqIRNvcXGn4
leW/42QsdLmT2oyzymTdxZ0nzh2C/QfhR1H0No+XJsn7iLEonQGbL9lkOU3j5OlAQLcfBMHb/70w
fQCWLtPZcsriRTpdoPuZ6eICIpbM5yGbQOCMGaDziInf61ZxLfMaH3sYHIesDx7g6ffBeaJVo+tc
GsPzulUWVvB9/e2Kry9vrtdf+efLL59+DOEPZnnG6ja3YMut3GUVqPouBIEtD8Eam22bcwI9kXYS
OsYgOPcDz9tIS5l1IbL9IAmTYQd/5e13lIeIUYI3+ZYjtW0NRyC3utxsqIbuu4GLhNB3b5dGbNq0
Pw9khxgapNRBRkJW2V4K3hqZG/jYFRHbHccnjIC5wcXY8OcIIbGKs7KAhCiKRpfKFihBSK1D6N2q
WzXC48aAupdAHYC6gMxCJTNj4V08KaBH6V5vS19TUi/sHCeaxp2KmFoRnEmFMhD11we8UcKrgRpb
NzBwjyE8PLgFYYtpOMP9YItFOD9dj7ustCdbASNnOTWqEIbGhjZ9+u/0mOtkU1cVl8pKjV2k9e7G
tC1zXWMZtRIGBoQkLOk+wq9e1o+cSt5bWrNHrhfvE8MDAAA=
------=_20041130102944_19040
Content-Type: application/x-gzip-compressed;
      name="config-2.6.10-rc2-mm3-RT-V0.7.31-13.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename="config-2.6.10-rc2-mm3-RT-V0.7.31-13.gz"

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
------=_20041130102944_19040
Content-Type: application/x-gzip-compressed;
      name="xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-13-20041129154425.trc.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename=
     "xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-13-20041129154425.trc.gz"

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
------=_20041130102944_19040
Content-Type: application/x-gzip-compressed;
      name="xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-13-20041129184639.trc.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename=
     "xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-13-20041129184639.trc.gz"

H4sICI9uq0EAA3hydW50cmFjZTEtMi42LjEwLXJjMi1tbTMtUlQtVjAuNy4zMS0xMy0yMDA0MTEy
OTE4NDYzOS50cmMA3Zvfb6Q2EMff+Sss5WWju92DTbJJ0CUvVaVKVU+n+9VKp8jiwKR0F8yBSW6r
/vG1WTaA7d0wA3loSYLQav3xeMbztY2dmxvU5fzx4fM7sgkEy8ItEUUQMhJVaU7k9RvPyDv+QJbX
xLvyz1f+2TX5/edPZOm65w6uuhvnhEQpK+/JPHSc2V9BuI7enK+u3Dc/vf984p76JGOPZHlJqlL+
smLeWLZwnDlB/Th5wViai0Q2pt/MB28hf4j8fLlYLTx3XoTLeZqezT98mn9xF5eLM2/unTlz3OXs
a/N3zXlNWCaKhJW+dOaSzOTtVPr4H/n39ct73yW/vvc98lHdflG3E+mQj75356hIWOh1WRGUa5+0
XnxNqiTyL1yPZEnIJDTnm0Sa4JFC0LxIuL9yDwFvbkkpgkKwiATClz7aUsHpY7BmtMpfuT88L3oj
7xcueRu6nuex68vbuhTLoqYMIW/d5rrdd5BbVV9t4VxZSMiiuYi7kN9LSzJ71TzJ6M9UF/hK9hTL
w53Oa78iKZ7GK7cllT7YkJl8kgFgBc2DUlBW5qcgkILQJEvEY5CImlZzYRBK12mw2fAQDSjzJKMS
sCazJxjUhi7j6RkIifhjRtNKsB/KECxlMOZqR1naY8wElapBJYsVitNSDVCv8+mg+S3pf33fEWUC
t/2vbzcifFUGCuBSg1R56zEUgNIWsX867nGdUBeh90woSVF2HMT0/K1jnve3fLjrGgxqZ8jzLY0L
nlI1kgxNOdNbfQ5VYtL/CAaMeKtICHua4nFEZs0jrHwsw/ZUNI6AzuhohwJBXYmQHgOCkh7TFJT0
nE0lPTpocunRK+hLz/Ox08u3kgEvCxccnYAUHLiXQYJj9IYsonmY0nwTbL/JQk2eD8w102uqVDPd
sJGP484NnHSf1CzG5AzonpXKi/sKoKR60GkxfTAM9jfPmJxkyolZGhRryutxscM/TrvQaN+qOGYF
i2iRfq9YxUbBWlGgSfG9DB4kTq8ASLQL4B4PhKGE0DQJJYQ6Bi2EOmhyITQb/NQ3Rgazo6gqggUr
BS9GY1upHNvXoKKrE5CiC48oSHSNlA+kg4LsHuz4lb7CK1he92ElFWNhKh8UhxYsLsfCgiiiSqZp
028Ro4GOtGlbvxogb4yyGTCUspkmoZTNFkmUsumgyZXNHlOLII0JbCsi47oHVIx0AlKMLl9WjHS8
THcpR/sAoDJVR9adocbue3KvDhisnxMa+nhAdBQ6L+AhAeaF0eiONE0QENQq1oCgJO54OAdL3H8n
lFdHV7GIYOrAVpYmgMFVTicgVU7HTKxyRjtrzWgHmqki0VW5aYiPRSLYy0W4g/8/xjnOq+GvCq+1
wmv1RmDoS069cFdiaxCwOEaiDQhKok1TUBKtY9ASrYMml2h76PYSjQhem2GoyEMlWCcgUxPuZ1Bq
6vh6O1K5B7IdqUMKlvIH1lta9rhHaZ6+dWtbUho1AJEjVpUmDJPPFpMw+WxgsPlsgKbO5wNhtawq
R8a2zdPRnQSY8gYBl/KIUEBS3sDvRuMRCdp99z8mz+lEoBrzJxfNCzcAyTxI0JpUbyH00DBWh/St
2tTbET040DKLKGo1QJs6QhInOcZhMQkliVMd4zBAk0uiXkHnlfOoWE7FOSjRo6idHd9xHRYqz9Oc
NulgVi8hz8YMXU7BEh4K8FEzg7Q7ofHEgxUGndAwSyMWTiYEpSrTLJzMsGBV5aUXTgciN/iEhlEe
cELD4mxokk6zbEJ4eVSSRlWabmmcbFgnVwek2dKYv+vvkmA4Y+yz4jwEz+vxQp6mPGtp9mqOsw+d
cilFIKpyf7ZuenIL7dQEAx7ajtkBYawx+zCmYeh9GNNpSIEzQFMLnNloyz4MJhKYQcqEYAapZ+I4
dJBa6oeg0DHUQZPHUK8g4krjRZIyHkfBFhZIHabOjfE4Vq0XZVi/ae7CYTD71hDGLHNPCEMBD6kG
ATekIvoEZEhdGueMDm4GDfGa5fSTbRcIibJu/2BYyH0fg4MM6cseqTLw9el2wbWhffAobDqvC2zP
zzcfoGA1KZGLrI3yosY/Tlxpc6Xde7WBEy1j61wW0wQRtPgzgHUT6v9Pkw7n+c6wIaroYXHOv76C
J/s6OAAA
------=_20041130102944_19040
Content-Type: application/x-gzip-compressed;
      name="xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-13-20041129195721.trc.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename=
     "xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-13-20041129195721.trc.gz"

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
0abiZv8Af9Ewlzo4AAA=
------=_20041130102944_19040
Content-Type: application/x-gzip-compressed; name="jack_test3.2.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="jack_test3.2.tar.gz"

H4sIAD+ZqEEAA+w8a1fbWJL5ap+T/1ChJ+0HxpbkF8aY3jRkutklkAXSO3MSxkdYMijIkluSeXXz
37fqPqSrh22SzunZ2TNKAlbdet+6VXWv5Hw2JzfjyA6jdtNofY5vxhPXsb2oOZnPX/zhS8Or1+nQ
b73f1di9zu/p6mq9/gtd07t6u6P1u70XiNUzOi9A++Oi11+LMDIDgBeBN7mcrMSzg3DFuDAm/v0v
crVaEM86zfbLcqv1svyy/J3jTdyFZcMuDbPIaF7vqXDHD6PANmcpYFgAW3hOGFmM+mWZCePBNY6g
zj8NBXzuBwxad+hTmAP7EvyyvPBC58qzLXC8CEJ74ntWOI78cbDwYAQ9bZhB8RazsT9lrEIAROkw
NjQ0D/yJHYZVJsubBubMRlbAPzTg1ncsqJvBVQ1eln97WS6hy9CenZ2Jv4hgdxc2BAOYmK57iUw2
CMpQbM9yUU6Jsbbsqblwo7G5sBx/HJqzuWuTWc7lYroWyRdIUz+AKmntoA3aEH/tpmxDyOZmDUjP
EtEgVnUF43oNEhdf2dEYSaZ2UOWe/uhcNIQfaiQ8kf6ZS/+ck/45ll5yvl48n/+PnzPiufyieeLq
8I+7gkbcJwqVnClSwwhxa0DO+cgQLoi4ieQcSR3YHIGj3LagOnV9M6qljWZ0T/STftC/wI4WgQc6
Dj3JMJuZjsd8h6E0acDkGtMOhdXtxws1slKhvAPCbyym5SBikiXEB/ZAF+axgMPl53hXfBES+ph/
ZComtxSfTLJ+kR3Z28uoMBQmpUNe4EDkA1OTh3x6GWYWAbdPdZxqXQcYKG2asdQ0YqOYltzGphkX
2RE0LTttecMQo+lPQejHzEqljrxReeXmjqUol9wxAUmN3WLcMeoRo1pTmMXKiDzp2XdClYRXE39V
a7lEwynQn2qeRfpqlrLJZrxaYwuLXP6KI6sen9hBEOtsgedHNNkeGvpDPsWpMV9iQV/iqxiVQQUg
lcnho+rUiyHQ2vOfjV7gKoYa2FdYauwgr92XpM38hDJDxh7mAGZpcstEO96YCXSSQcqcchJSmlW5
lxug8ExPSAP+883+f40P3v71zYej8/GbDweHJ+Pzv79/iwPI7j1SHYaH3nwR/Z7cn9vBzPFMt4GZ
bVhsg5+2wU/bgG5UjfCfZ4T/R2yQOitmnCwitEsaUZR1orEotuM1xbYINdZbDAhBOTHmJHJuzche
wloOC3aFLMQ6yXHgSfDu2nHtKiXu0LXtOX4aPhF7fpdOo4K9KKIFskvqUp+4fpgaxL+W7dqRDR8v
IG6rFFjcU5WSuqXJuoW6ouKACTHTJP6z29Z/X9/oSspRZv/ne6HvOhbGmtU0727+iIw1+79ex+gp
+7/+C83Au/6/939/xvXdq9al47Vwhsvflcs/vv3p8Bh+K+MOCc7e7p+BuKhmMuD7k9Pzsyxw/+jw
7bEAJ0BIrhh4XAT8pQh4jpn0bDFLA/+G+TAHPLBd80FA00CDQ2PgO/M+RlaB+w8T104BD8K5lJMA
zx7CPPBDGOSBx87Ezul5ePI/phNlVDoMfi0Q5E8jOZBgelEecz+6TwOfyuVy6x9nqe5c+vZTlab0
Uw1GLfgtnl7c4vylN4T9zc0hPCHt8WJ2aQeU8nkVCYlQzLCklRMuaInsPevd5kgpWlAukcWLJJPB
E5Mh3bkzs6lo7vsLJGpm/uwQWbl0j8Zh81b9i27UhngvgwMZ3dP9L7TNvMeWTmfD1M7+UoNjMqnM
pPzt9MOxEJGTwaTg9RsIOjXKSFW9zU1ksSO4fKruhXMzsCFC/dE+ySZmokYlMdnGHreAiY6pAjC1
TMKlTEQU55lg5DozHFtjjhr1zByDm8Oi/guYxKtEZfLm1g7MKxsOzt7DkW9aK5moq4ox0dNM9t9/
oEUW2TPGq5iJugqJyUD4RGXyAXO1yiLHRF21TBMtrwkt4pVM1FW+jMnhp9YJ0LpPODEuMRM1Kywz
5/D0vzn5Mk3ULLJME0oqWzGnIscqWUcNNskEExDuBxfzCE6xKYAlmihZqojJvo9c7qOtszsnmlxz
TjkmalYTuYKSRfnt8YGoTT/jgm/3cOm0oHqM+0NKZjWeEue454mm1Y16csH+yfHZydHhwZvztwdw
+vYMNyVnoCDUP3kbGfJzPzJdeaIBgemlAxtedy0kahRJzmfQYlKZRVuwn+GQT6bFHHhCzdPXv+Ri
tkOKHr0/M4MHOLVDOp3JJE4mH6VKLY4b31wBWRXUSFMcUH3db+rTWuvaXwRMBVkQ6vBzRhOW+UWY
FWR+YJwg4SSTf54TT7qMlZr8a7CEU5x017BKSsBqVsYqXkvTOJsrECWGeKnloAXHGW5rikIRt7gu
5LmtqQ7CztevuZG8OiznsqQ8pLmI8rCaS0F9SHMR9WE1l4ICkeYiC8RqNof5CpFmk5SINYzyZSLD
iGf3NR7O14mMh5M6sZzTkmIhIxvjh2vkrbOruF5k+YiKkefzNYkIS80/e1f2513L9v/ezMYZbK7a
ET/7Wr3/72ICbLP9v6HrHd3Q6fmv0dX/vf//M65WC340Q9sC3wPP9PzInzcnMA38GUxdfz5/mN7R
celnexLRaeCp7doMfeFZmEN/en9EUFql5iSCmb0Dt5b5H3Sk2HRm0bzpuA/O5Nq+DW+avmWHodlc
mLgha52fHJzsANGGzmzuOtMHmCACAVp0Otty/clNmNziJEU7dGs54c3Y8Xeg2m5otZ2qYRh9o6H3
twf9RkfX+prR6LT73Ua3g5FWI4pLqtKga91BR9MHPaOsPJqmoeb1Hp3J0sdH38OKfOX6l9j73ZpB
TX2y/RC2FPQrO6I7f2qZDyoWO3IXOHiDf8GOJikMywwkxrTabDZVKdOJF7li8GR8enByfPR3VNiy
pw6q9svb07PDk+Px2fkpbGjNQbO9EY8dvD06fDfe//nNKVSgQj4epa4Y8fgINjDTlaOHuY0giB+T
u753xX8sXPo1XIKy4IPJKIPKR7rDFaJpKsdTB9FC59GGjjboJWzQVYtJlOCIVp8/J2XPLdg9PcS5
sr2hMkjYw/JTQoo6JGzYJ4of3DP8BhtJPGHd2NLhaZjF9exobNm3KjqCWghaRjGzZ4439VUKAVpG
QWFMOoQqTQyMqYRPKNJuMSSj22FZ2D/a0vlnJzR6I63Q67id0tKR5/gYW2X2RoMlSiQd9EbSkbOo
ARSRwve35th1cNScD+U9Zcuoas4bgMii2N4KVozcnNdiZNuzquz+qfyd7YZ2GUu5HXjwHAWIxLOc
aYFhDBc7fnoyTzF0MeSg+mQRjDkc3co/cCdZthuZCNN5claA3qMKLpP7nQkGmUvxyvQMbHqWxLlV
pWcKJT1l6UkKHxxPaA8Vk4vnLAmXraU8mA7MVVkdHPRdzGCP/6Kx0l3gRHZVbwjZjbwcnJJSoQnE
94mU4GIXUWp6wlg0vXRDnsMAdW2vGoo5R5UQvAdVzm+Tlrk/FXe12lYis1YuMQbrMTlnXE+T+YNi
cANC/PsoBCvGbKJWj0PVhvGkyvSfFHoOdqFYh3JJCajNTVR2wtgWxmOdFzJ77ES+WRXuaghHNTIZ
9JYPzE2LNMrxIxVDaQfd1Le2KFFUPmkVDmAPEKGKYPK2Ju1ScDc03Wh3uj0sjBsfb1/r2sUwRkG5
W1vJ7S20aAkkAHTPq1v4/ntC3B0h98vANm9kcCjxGxb7g2xDCotl+kfhDDZl0h1JUNVhSrl9qR+I
Ympx2VNr5M8x2hhFQ5bHJPSm1i4qG7+HwP1IQUbK4GiDdAgft3QZNOxh6dRSg3eXObNEqUW7GHGP
l9IsuQsII3yUKIpTtBVOsTCLV1Xj52lf3NgPDUhe+rq1J3E+LvROnKCDq/E8CpIK6WB7dk/5IwPy
MANjmmNRwJcvPbCfN1Bw4oVXc9WLJYG9Ga/2BDkpCFyBBqDKkpFUgRKsAiIVEISkSJQQOp4sJ8nT
cXZb4vf1+WiEjQ38/juwj5+iSg3mm5tDOu/no588ZVirxHGrBrai1SjRB2UBdlwUJxBdOyFq5y7s
mI6tK7SMJQF0QuQvXHQaHH84Omrg0qkNU6jPMzMJpdhCXMtoIjeL9AlvnDn4uBXO6BMbQeYnfGTF
5bJqXxSVSUeSjc9UOPJIRLY68TagjT87TKcu+9mrBpjToM/13GY/B+ynrlXvghroOh/SDdDb7EOH
M2Q3GlxbJnR1Y4DDnU5Hh+0O9vZtGBg9rWuA0e3rfegPel0NR9pGtwdtzRhsax0k1Tvbne4A2oNu
b9BuK1x14qojBv+zuwWYi/3ApvNm33Mf0IKpY7tWuCQVSwcEVsECSx7GoXswZ6TvdeU+E9eFE5ng
LY93JZpzoZ4b8yqqvOy6RM1KBEvxpQtjIHK8hZ0NVcE7tYp6WQmBtXaZPAHrB5ex1LUsT+FcTEI4
C0CLg28h6yHuTP2A7Seqlu9VIrjx/Du4xn+Rj/NKr68s2CvCAq2W46tfiOS2ROGSOiuveJ7B6sg/
a3EaWue3L1nlT89Yu6y9CScmMo1DdOEurRWsDFPV6l5kwjgJ0YUL9aQXwFlZuHsDvOpsQkhZy2fv
ATKxtH5oFPwAXNzcl0UiQy57oqlmxVRwZl2G0RGeYpKZ356ExXH5YUNI2arTSTNQIwNTP5jhFq7e
krWZehxQepyF22ISL3hBEAV8xF1Nd/oyEt4cldSooOBUiLSlREKSnpJkLJGU7sIK5RlL5AlxhNIu
RkmY87UlZm+ka3zqYl/eqL5EJJC+KnTORQ2EadxDqzwplGQrO4O80qIlRudshpt3P52/fb/xkQVI
2trEwqbxrjhacgIkd6ZipVlZoc4zdYk7w46S92kXxfdchZsHtdoGNj1XqiaHBfX5VNm0vJpPt/YI
jslDfKItFCOuzUzX9SfV9BlL0tQRwZXtwasRHR+wdSlBI36gUlJ6dsm+kTmzaTDBrGMv2A9IqmJL
5SnQ2fjs/M151azBp+zhj4nz+IkXXQ4I+clNnfWtYojyVrU+8V0Xc3qtGpPi9lSiqJtW17y0XZX2
zrGia+wKhR5cRK38JIQNk/O2d2+Ojk72ORpp2qAzQaBP2Awhb/Q93cS+FxtIguH2Me8B1pKwx2cB
ePT0KOSPsxwLJxIc/44eAznBr2i+P43oQ9U10ZA2b1McD4xmjw41J/MF9lqdQbs3wIam3cGGqQ+d
drvXR4Cu9zoa9HUDeyh9u83Rj5+NHp8TQl+6COmFk9jUyGLju9bHY6WYXJrBWG5ZxabPDOhgTtIX
nVIRoZjLMeLFssRpQw6/FIu3zMhE+XSCpjWUP09DBWkamJO1SDh7ohliXxXC5DFOg7hl1NVs7Ukr
S7GJMVxgO2gnZVa+3ZOL+vv4ILLWgA2awY0GswE7jQYYDWg3oNOAbgN60OjT8UNJ3YSxt5ouKf74
iUblY6XG4Jjrqs6I3mnfPZavsdMb4MoscQVpuhzKYqQbc55zQYcfLnbsHEkAh6VWKzQ9J8JwJk6S
VMFAMHkI26aY09aIsWIFnZmPCHwG5UnfBqEaO/SqRWmZ2iV+9gy0d+Kerlc5qKbILsVztBnrhAQR
tGguGQabeAF9zaGKJvDaXbTw30ZDUDcEPtPtKYUay0J8etoo7xkq73gkaJerLEyJp2Bm3o8Yfywi
/OTHD+nMFnFaLe4InRzREY6gswyuzt4IaWsJA/pCFhE7Q/F1KEma8mHpuQyeYk8h7AJVQn1M1lde
LmZzhx/r27wvhegOUxYRMJcRAbVviqeIxrbgtUNewvFaaqpYr5d2rVhWnEC4LsUR86MYZTKNi/Tw
IgzUYS0zzFKsMq7z2Y0XEvPVzJ6FdkSABrYAiRaZobNKogIF5uZI3FILj2pm8T9UEp0UfI3ho95Z
/ONKoqOCrzN8TzheJTgQBJ00QYcR8FKSJTkUJN00SZeTBL9m8R2B30vj97jNvEKxKaW/oucUrlXZ
/KB4tZz2PrVGPHUyj4vMdsEym2zsKAOxTU7if9o0MZcrA5oY4L5VBnQxIJyojHTESOwtZawrx5iJ
ykBPKiDtf6IkvHqnxhuLOi59RxQ5pT/B4mDOVp5/ypqqtiOyTDbk0Tu6UZRROqhOCmo8yvogal1Z
6YnBrBti34ctJwembC+MpYtUk9thTT0mpX0F7YHDx12+wYi3NXw6c21p+LipK/t/jsUOULUsVFTa
xxRcqol8jHTjn5dM+hYz1TWtoG0VLWC9tuQ8W3RB9AimuAtKWiDPV9ofbzFjTqcVg12QpF/XBdGb
zhJ3WReU0kBmingHvarxQM5B3HigbzyfWo2k08gZFzcP8fSL9VbQO2jp3kG4P43AoerChS3ROShz
8pyVRI56/kpSV4907+rVg1hFy0RuqEgaO2Pgh0CYqJg7+XF3SV1xNLsbmajlraZ6UJZdbDE7j0Je
ZUgDIrYEmow0embhVDJAHYFeFmggMMoC2xejqrc7GsAPUNEqmx7soPBq5U1lS9dqtQxy54IOKDPA
rvpE5GtW2SS6X7rKcCchRtfuJKL7mNO3X0PIOUqa93/Z9cOc9FXrR7p2TfWJ7guqT3RfXH2+PFQu
3RslVNSDFNf3b7A5Hub3qwZLxZJyXRghntGJ5Tw/kAz1iHX4jJAiD3Gd1T1hjVuWjS5l62Qkbf+K
Dd8X7feKt3vpXZ66vFOhWKcTXvkOJu/moFLLxayeQlz/iEqdj963nQ/lwVd6ZmJ4jU9JwTL/vzwR
Xfqu1DPmIcH7oml41iTQY53Q6MVPk9PTGKblptdcuOS4NJXASI+vS2BS+9UJDLGG4tAuXfDDCpeS
qvKh41NmE1C+mhn8zpxvSD5J/VdJLzlphnBuXtkJYTZlDr4mZSLnmxXlNR5elxgJMWH27Sus+Ia+
Hf4/KLPMV18XprGHV8cpoeUrLUE3+LNSbCOjwHRcdqIzNyf2DkTXdmDjbnmB+7MH2GXfQiGKsJGv
zcAv+p8LbGJkCUIug4baG0QMAX0rhgHp6cnG12yypstOmjtiTlRPWvYt7urVE2cOGaNnfI9tuqbP
23NNpeTnx3InXVRWhbV4pZQXelVFpdq3GzDAD0VxrtSZzjevM2JyobDcyMHlVYdXF7G4ad9Qr+Cu
obDasPO5DE17DY1x8RX7wvRLpdzfz9sXTp+zLZzm1poah8rKkQ/SJZyj5fHViMifnPCXroQVm7Ja
I5heiMzGk0BLcMwoh7Oxs1H7muIxs2dqv83ewp1HtMrkyLplhngxl2ULTTwkwyui72Du0KdFaFvs
wzSwMXdBiLIJwv+7sBAhE3NyjRCkfmfP8N4YtLXe9rYGhj7o9Nq9bYB+u6dhtyO5a4ika7rR2cZF
N+j2DIPeRDrDYr1D50S9blfXOvTGgtY32gYMtE6nv903uITzWDW6jO2eocHNj3zsr1xHefX17e14
7EwonlxEB7C7tQU/IMqPsUExb3rviZHvcxMV2oG2LcSS2ulxozvoKazLIoEf+xGYt1gKzEt6gYM9
UdwRg0uSl3iVncoy+Tbz1IqeV4l9Cp+5zPuX8TOQMZvOHJRmNAfEeQ1zQD7FK3dTaVX5JKG+3wvh
wNqIjIbPYsXmFDkRK9IYvpKVnN//be/onxq3le/X5K/Q+eBIIF8EyLWB0Lke6ZUpBwz0YzqUghM7
xMWxUzvh4LX87293tZJsxyFwvXd9nYfvbi6WVqvVaiWt5NUuo8J2fiwq7m7EhKgkd/JQxXR3DmcB
GK3agN0GLXRlsNI28z9NuiVu3xr3Av2QuMs7O2gSlTQ1k1gmM1iY37MF2OFbTq2yg6osEfSD6q8+
VP9jzKRSSwNOQB+niqlp6+G1AaDmnW1I/nfULiLVNypxtndS2wTijDWnB1KQwM0MoOZ8Cg7ozcB9
zJld/GFsjCj496KlAOB0uaftHx43PGgi13NVM61VFeaqJk+QJWzBx8mSavfDsgRQs0o9JH6q47OB
ozuNfy7c9Tmq0EM9RtxAMyB1OWe2G5tqG5gwOZLmRmxCQ0ZOFX1b6y6uD+AvJFaDSCkvWgZkScvK
HJ3N7BaT3V01X4Sf2O3AhI/czDmP2co5ORs551N1OV4kS6hw0vut2zf7GOIRanQacpFMIKDBu1Au
yN6uRTsQsd5sb2y2t1o1aWq344b+rrSJMLaFbIYnW5+4YUPXSWDLNLmpTW4uYrdfL7Uaq61Gebm5
id0vm6TN+Vba/Ekig2NtI4Ol1VhuNdIIth5E0EojSJVWYgrdhmzWN0u+MAaHsBHLIPySNokIvwaC
XJKY0eMCLMWQQT1Ub5ZFXb/pAmVCKGBA3OJV3CicBo6YjoXx1hq+KEs3s2GtVpMAeCYQjrzJxHVe
iN+mINhoRjlC+3jEid/078KpCFz0pDx5Ibbx6taDNCdIzifSrDPGNvKJo5DE7mmf0Y2kp+z6lOg+
PC4RbHZk8rAkPnWEWsWrK+oDGJ4aQh5eKmIY3hEqC11M3W3p3NbMMP9ijbLWBIG+6DQMkapW3SzF
anPhRlonUb+siR1Q1Gn1l0AJQ+9HTiKS0UOYst1oe449em/q+c5FcIFb/KETleKF04KkkfLpm6hv
uGSGj/q6+aJDVtZSSyooCVIAZTbj9hM3ExNZ98pA3Rc7Hc1kbaKeOCcvMJ6EfToxmL+90iWqlBBj
QbxrwUuN5NHMVj59F1QbRPDdRlnI3NpMQzOsBDpL552nLgfW6+nrog/cHnh8L6H1say7PNvH5YRQ
o10xdAnD0oSUJUdybi5R0TS4CIO+a6iqsN3uZIh+aiXq+aReuYG6zkK3B70onmSHBItbrmzRAmSd
wai5EednB2++7h6co7bA9xaAEYRSGWKai/fJ6yIINkNwVlbVxwC55llYI1VnakuWIHlJSKOknico
aJEWZGKWMBLOo0K2/EO1SldGjbnVVyvl+VJeUOxrPNRv2ow7pShNg37OFA1DJJEIWyIP3s7IqD7o
j2JYu8aTnoVXtBlHAp2B/YP7l477KmqpZfuqSuIVBlfyFfTn5OvASZX10DtwAtXkNgUcRtcV84pL
QuK150PmPalLiTv33lVgo0MHSOV73fLaDsy4sAeg3Likb9WBdnGFt81BEYtxhjWp7mg8uUOTuldx
XN426bbjcGpFnO6/O94/7uL0pfNRfx7Z8XUJMi++hlXvu4ogYLQzIUTzPvbl+KtfFcpf/bzNGo/Y
jNCoZDJmn0mNzViVMwWPFwOp3DwAs9DBNIrKL4GVzBsnxnvylt62OvjKMJzT6UoTXfiEHotcx+v5
d2J65UtvJALSp9I3CqTg9w3tJKQXAXdguzGyr9xigXSIiZiMxmTVS1aIyWI29ASgcwcDVCrCAXb/
BPUudjWi0d7YEWzQYamwfVJwXgFK5RvtPqVSYqd0OutlNd8WC9YhuewRVtpNCJo+hx9i0uEmIeh1
IKtAErxG+vpBgPswSYYlDg+KBfxnHcmh2ZZJFprRF1Txt8c/1MShqKJZqJAXQ5Qv/4YoBSGml7lg
oeS7MCc7bXHa5hp/aNMdiMM2GmU6Yq/Ndx/223jpwWuzcaXCEOx/8+ZtV1ceuJMP+N3JQydTA7vv
Cspn4NHZoD4xlNLKi16M63h6UpfHTDAphNEdF4hnYQV9s5XZA1OvduxH3YvbTseN+5E3xquFDO6d
HSb4RNXV47Hb9wYw9tGvVkSexQn2VsP1pZ8rPg9Kwow1jA4zAp2FPZOE6mmoHnrOEV4oM+p1q3cW
n8/kgq4HLYQfisUT7N2Ybk2iu5wSrl3QwQ4QDsqLGIfA7FgBOyQKnu97amfRgy5x3QA2G+gxOq6J
PZYG/K7IpYZYika4UCPc7oU3LvM1FiXX7mOleAs0NgKFuoCq2af1sSAZeiekIj4g5rg3XjiFgQzy
xcAHDIwm7GsM+wGoBmrlTAOdyGu0iKeR3g31fDu4Vv0ZMck7/WgXJA7E1yaH6Dv+YFfA9NU9OpCQ
uIhmNZ2EXbAcwvTfAD/FkScDPt+4gdZDh1q5Pg12O/IWpd4+bzT5E19jJ+XYQJ6ckOsKvqyHxheo
hPI1f4SyDrxgeiu4Rjz9r1nlFx1eDQoZlwhyzklcM8Bpx3yBZBcC/SEGjKHJokILhHcuD9SQyLFW
S3BCz6zk4yqXOy9xQankKPWGr7JIZYTv4xSMBgYvRB+vNjHmytuHUn2H5UYXpUxegGKugizXca38
GSbHoQ2iCDNk7MLEP8Ht8VW/LzZqTVoLHHVUWxZ2LDYboLm5I3TN+dt0NBYT/JqCiI6+FYdHL8Tu
7m7716NifdVcevsJL7wxDhvbpXK6h3unPwEp6v3tm9Nuya70yvJst9Qrt9PQCADwq/UMciecxcpK
H+4aZ/EDI6FcpwNVlHOrKCBi06HFgiyrUyorkboXml6cI4s5zAfLBcaZg8FRGJSPHrY91/JgTGJX
18lJj4Em5z30a7fxFSNo0/nu4+oeqrrlgkrpeJWXDHpRQc6oI1WFmoUsmz+f9EeT5CdIQmkts9Ty
HqCjcT8a40EWI40pA8FGvHm1mGGSWxXJGM8TBXPekeIJMo3PvdKbRjmCc+ZMM+/ojSDBVtLaoT4y
SnpnMrY/JBQ8cyZ9tYFKdVOh/pjKaBsSkj1Aia+ULyjRlvJUNYdZyyxzKRoTTh3m1KOPBtF4Qml6
fEMwzSzYluGdCtCVlme42CibQ4oU+xYxibRDPTrzGE4K66F7BUoFzIByFFV30WZIsghXOdCMCOx7
1JVpDR2GV2hDRD5De7CAon7ZtwM5jZ503xwc/CzeHR3tFZVzPeyq0J+S5rItTyGlCwcH1Fa8wBs4
Qt49A2ajOwGlTMgzTd+7dtvoe2CIS/TQHsP6GQv3tu+OpYM049ch2/9qNxC5IzVfgOZaUvcKdQet
ct+vmT4vq07noQCUnIagZ0N9sbh2owBVCvvaxY0CnrTS+akN9AR3ogcKrWtHvgc642QIrIFtmOto
PHvSk8JViIsOrMd3AtSvCDQR4jno5LQvwTVAD19swI5sQH29+YUcyZi4xs1KD1iWcAAwG/x79d3F
nLT+3S4on5+/8Znn/xWmlVo8/DR14Jh6vbU1N/7LVnNL+3/d3Nj4V2O99fr11rP/18/xcPyXeIjh
X16Kt+FohBMxOeIBLWCKOm5cK6Kb+87SepF91neWmkVyPt9Z2sBix3iyR6cPvGmDImei+m9hLf2B
Re8tnHTOcXUjTBuNhs5nlABC+aqG9ZaGoJoIBUHIijex3vcw9eLWzRV4nEHnJviRy4edZUTWTWPf
7ru14gjh8Ar3rkA/nvUApn70rOTewhy9jpikv2Pchw+8q2lEG+xa8fB99/vuSceqzbpGtjjz4s3J
u9OONRF94Ylb0RMjC/HJkHkZdBgVba9j4f1f4joBWTL5Yu9k/0esy/ZjW6d1f9x/2+1Yww/thko7
Ptk/6rQa/Hby5vtuZ3MTVi6V3YX8vU5rU73LbiqVSobVsBsGjWVVKNbCT/xgLgvI9lRvRPVEVI+X
/jC13ovqWL/LglVHJUjyUylEPKREKgWJTSEhWiElaIrqKdRGrOOYB8jsLANlAzL9IeEtzmT6We50
Ewkzn6DUJ0Py9Eau8zI1HO/vHX0DXRRj/4w9JxxYxeOD/VOodByLaoghGCsT+NcHfTmuRBPQpsJK
4FXg/8oYz57pW2IfxhFVeQBqEh4UUZC84sHRu04yAuTllCLwVaPL6iXqOmJtZfnn5dGys/zt8vuV
y5ofXlnJYeneuv0pqWk0SMOrKzeqFTH1Al5EqVwEjeDte5CxpVWrWHD7w1BY1fzHKhR2d4E/QNO9
aO6+WlfwLyERcNxb6EkgCyKzCnlZWDov455miDTrkUmgMckWwGQxxr5ItAG64ZQb4Q0ETAQBTQSQ
ivPENmqeAW72ZQNF7h9rhkKgnvoSJG4kGN1sO3RDshkDj+IrvaRjvDkN8TINeSKFhsBqjMpgVQqY
qLril2IBJqyrCJTDldKvZ+J8Dej/E0j5EwWqvDK3P2a7A+Z6KZm4TcAQkVCdoMO/OCRF3XdvbPIO
NkA7AQCXzVhdXRWn6O/RdQTJ6yVGUbFEpgYJnUmUGPIjU1FgqjLo5mq1mCFals6JTaVCU8nSei3J
L58bpErGqJLlea7Ir36mlWrYWTyKYdpOJPZh2ySP9+wYTxb1Kd9DMH07cmIc8gaGerwmjCWU3HbU
Vy/GkYufhQjnvAJe9Ht9Ff5IcXWdXEjESifD9aGzWv996k7d+si+vWCneRfXvTkt81SYB6JZ7g7h
r9wF9fBcFTq6J5doFCQzOlgG7Wl/qNZe2vK4AiN1XtFZbEL0cPwDcNCn3d9lD3ZFxPOlP+QqfH8J
wFaxpN91Dq0H95nOK4tXRbnParJoOLApBwQykTQCSRtSJFciKTHx1JtQU04Put3jTiuPvMRCq37e
41kmnh7b9GG7TNTiufXhD++x4Zex+7tYT5S83BZOCHO5XNNgzj3YP+x2tLpkMMv2wTwpCVrCdZ5+
4iq/gSfBJdkolbwtNMlLUDtSsi1052q0XOU9sgqZk+YT8sed8CUi7GCcN9wbz3GhfThA1ccKOT8a
hqXpQ8vxGfLMWlB9m+pqUhqQM3MhmDmXSDSTKBUxH9dM5Dd6IA/wOBfPLHxv5OFcRn7955DIU1Ie
odee76NSmUOjJEBLkSQC12z6zIWE0BFzUrxPZMjYPGwkLYkuksnqh5SAeXKs8X+H32sy+BW/qIKX
ee1REKh4yxqOvqtZpDvT2zdv9g+6e1haV/lgjanhmlehAlhYYWJN4lDCi5al+C7oa87QC3SQinWF
nLUD278LPBJXnOS49J/C/nAtqokguBsXsSyGoVEhf4IW6zbD/6PCx8zb/yfa95frWBD/dWtjfV3F
f33daEJ6s9Fotp73/5/j+bzxXzFOG0eTM4kYcm0mkWKUcWpOYtMkqoBmqYpUXLJU4l48xqBW6biq
kKgqN4l/OdTrh08Z6hX/lzzNhHvVGYe6CYmM+39UKNgiRdchZ836AiAAaokhoqBVdTwfuRj3R21x
Cy3iyJFahjTYrw4JRThIYjMCZODo248BysA1iUSOdgo6sYx9Vzeg6D15aWObXJ/dil0teSZmqqAo
tao8kZUt30qVp9pN4FZT3seQbB1RT5Eqw+atSSqUNMsuhCJnjeqXf7bP19AHp6Bouhn55oJZCcfk
TU5OyDgmb3FyInQpd2NWzjH5NScnJJ0Dg1IyNR/jlWL7RzZ+Hb+tCOvaKpchb1W6kd5WQ4IC/ibK
NReV4xFjyh0q9uDwMAFFc+PFidMf3r9/c/IzhwwVc+LFJcv/X4cNXRDLuQT1l3W4TgLKYlgQp1m3
QA/3LIJkeOV0lM40AjPAMzxII0jG5pyHoJmL4ekBOTNoPjYSZwbNx4XgVNPIHGRPjMS5CNUTwnEu
QvWUmJyLcD0tMOdCbI+PzrmQ9U8L0fkQuifH6XyQtqcG68xD9pERO/9Je67/pSe1/8PPafix4hPX
sWD/19iEPR/v/xqvt17/C3+2nuN/fpbH9v12Yebjppj5vFYszgDllKv1iwW0mqyG4kGcGro4U1EK
q0yq9cdjwLu2lsHLWk4uvKj6mF4swpJoB+1iIRqJ6s3gYbK4qX93nzw/z8/z8/w8P8/P8/P8PD/P
z3/r+Q/iVZseAKAAAA==
------=_20041130102944_19040--


